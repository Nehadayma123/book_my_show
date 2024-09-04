class BookingsController < ApplicationController
  def index
    @movies = Movie.all
  end
  

  def new
    @booking = Booking.new
  end


  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking, notice: "Booking was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def booking_history
    @user = User.find(params[:id]
    @bookings = @user.bookings
  end
  
  def booking_params
    params.require(:booking).permit(:theatre, :showtime, :user_id, :show_id, :num_of_tickets, :price)
  end
end
