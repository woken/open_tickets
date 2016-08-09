class Ticket < ActiveRecord::Base
  belongs_to :notified_by, class_name: User
  belongs_to :created_by, class_name: User
  belongs_to :issue_type
  belongs_to :company

  has_many :comments

  has_many :pictures, as: :imageable
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true

  has_many :tickets_tags, dependent: :destroy
  has_many :tags, through: :tickets_tags

  after_create :create_pull_request
  attr_accessor :new_state
  attr_accessor :action_user

  include AASM

  # casos de uso
  EVENTS_MATRIZ = {
    open: { checking: 'Pasar a Revision', closed: 'Cerrar Ticket' },
    checking: { developing: 'Pasar a En desarrollo', closed: 'Cerrar Ticket' },
    developing: { testing: 'Pasar a Testing', deploying: 'Pasar a Deploy' },
    testing: { deploying: 'Pasar a Deploy' },
    deploying: { closed: 'Cerrar ticket' },
    closed: {}
  }

  aasm do
    state :open, initial: true
    state :checking, :developing, :testing, :deploying, :closed

    event :open_to_checking do
      transitions from: :open, to: :checking
    end

    event :open_to_closed do
      transitions from: :open, to: :closed
      after do
        self.closed_at = DateTime.now
        TicketMailer.delay.closed(self)
      end
    end

    event :checking_to_developing do
      transitions from: :checking, to: :developing
    end

    event :checking_to_closed do
      transitions from: :checking, to: :closed
      after do
        self.closed_at = DateTime.now
        TicketMailer.delay.closed(self)
      end
    end

    event :developing_to_testing do
      transitions from: :developing, to: :testing
    end

    event :developing_to_deploying do
      transitions from: :developing, to: :deploying
    end

    event :testing_to_deploying do
      transitions from: :testing, to: :deploying
    end

    event :deploying_to_closed do
      transitions from: :deploying, to: :closed
      after do
        self.closed_at = DateTime.now
        TicketMailer.delay.closed(self)
      end
    end

    event :reopen do
      transitions from: :closed, to: :open
    end
  end

  validates :company_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :created_by, presence: true
  validates :notified_by, presence: true

  delegate :name, to: :company, prefix: true, allow_nil: true

  def events_matriz
    matriz = []
    EVENTS_MATRIZ[self.aasm_state.to_sym].each do |k, v|
      matriz.push(
        [v, "#{self.aasm_state}_to_#{k}"]
      )
    end
    return matriz
  end

  def change_status
    self.send(self.new_state)
  end

  def branch_name
    "issue/#{id}-#{title.gsub(/\s+/, '_')}"
  end

  def create_pull_request
    git = company.get_git
    # TODO: Use develop branch instead of master as base
    # creates branch
    branch = git.branch(branch_name)
    branch.create 
    # push branch to origin
    git.push('origin', branch_name)
    return true
  end
end
