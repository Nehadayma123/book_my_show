class Seat < ApplicationRecord
  
  belongs_to :show
  has_and_belongs_to_many :bookings

  validates :number, presence: true
  validates :available, inclusion: { in: [true, false] }
end
