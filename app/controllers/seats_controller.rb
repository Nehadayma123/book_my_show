class SeatsController < ApplicationController
  def select
    @movie = Movie.find(params[:movie_id])
    @show = Show.find(params[:show_id])
    @seats = @show.seats
  end
  
  def finalize
    @movie = Movie.find(params[:movie_id])
    @show = Show.find(params[:show_id])
    @seats = Seat.where(id: params[:seat_ids])
  
    @total_price = @seats.size * @show.price
  end
  
end
