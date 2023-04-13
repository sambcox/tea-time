class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title, :price, :status, :frequency
  validates :status, inclusion: { in: %w(active inactive), message: "%{value} is not a valid status" }
end
