class BookingsController < ApplicationController
  before_action :authenticate_user!
  PER_PAGE = 15
  def index
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @total_bookings = current_user.bookings.count
    @bookings =
      current_user
        .bookings
        .includes(:show)
        .order(created_at: :desc)
        .limit(PER_PAGE)
        .offset((@page - 1) * PER_PAGE)

    @total_pages = (@total_bookings / PER_PAGE.to_f).ceil
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @show = Show.find(params[:show_id])
    @booking = Booking.new
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def select_seat
    @movie = Movie.find(params[:movie_id])
    @show = Show.find(params[:show_id])
    @number_of_tickets = params[:booking][:num_of_tickets].to_i
    @total_seats = @show.available_seates
    @seats = (1..@total_seats).to_a
    @booked_seats =
      Seat.where(show_id: @show.id, available: false).pluck(:number)
    @total_price = @number_of_tickets * @show.price
  end

  def create
    seat_ids = params[:booking][:seat_ids]
    seat_ids.each do |id|
      Seat.create(show_id: params[:show_id], number: id, available: false)
    end
    @booking = Booking.new(booking_params)
    if @booking.save
      UserMailer.booking_confirmation_email(@booking).deliver_now
      redirect_to new_payment_path
    else
      render :select_seat
    end
  end

  def booking_params
    params.permit(:num_of_tickets, :user_id, :show_id, :price)
  end
end
