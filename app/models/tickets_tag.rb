class TicketsTag < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :tag

  validates :ticket, presence: true
  validates :tag, presence: true
  validates :tag, uniqueness: { scope: :ticket, message: 'should be once per ticket' }
end
