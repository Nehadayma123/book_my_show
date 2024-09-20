class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
  
    def booking_confirmation_email(booking)
      @booking = booking
      @user = @booking.user
      @movie = @booking.show.movie
      @theatre = @booking.show.theatre
      @showtime = @booking.show.show_time.strftime("%I:%M %p")
      @num_of_tickets = @booking.num_of_tickets
      @booking_id = @booking.id
  
      mail(to: @user.email, subject: 'Your Booking Confirmation')
    end
  end
  