module BookingsHelper
    def seat_class(seat_number)
        @booked_seats.include?(seat_number) ? 'booked' : 'available'
    end
end
