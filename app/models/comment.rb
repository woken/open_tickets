class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user

  has_many :pictures, as: :imageable
  accepts_nested_attributes_for :pictures, reject_if: :all_blank, allow_destroy: true

  validates :ticket, presence: true
  validates :user, presence: true
end
