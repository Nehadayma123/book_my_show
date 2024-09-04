class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show
  validates :num_of_tickets, presence: true
  validates :num_of_tickets, numericality: { only_integer: true }
  validate :num_of_seats_available
  private
  def num_of_seats_available
    if show.present? && num_of_tickets > show.available_seates
      errors.add(:num_of_tickets, "cannot be more than available seats")
    end
  end

end
