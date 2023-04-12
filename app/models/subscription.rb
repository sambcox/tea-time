class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title, :price, :status, :frequency

  enum status: { active: 1, inactive: 2 }
end
