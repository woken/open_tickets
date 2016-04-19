class Tag < ActiveRecord::Base
  has_many :tickets_tags, dependent: :destroy
  has_many :tickets, through: :tickets_tags

  validates :name, presence: true, uniqueness: true
end
