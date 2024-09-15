class Admin:: ShowsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_params_id, only: [:show, :edit, :update, :destroy]
    
      def show_theatre
        @movie = Movie.find(params[:movie_id])
        @theatres = Theatre.all
        today = Time.zone.now.to_date
        @shows = Show.where(movie: @movie, show_time: today.beginning_of_day..today.end_of_day).order(:show_time)
      end

      def index
        @shows = Show.all
      end
    
      def search
        if params[:title_search].present?
          search_term = params[:title_search].downcase
          @movies = Movie.where("lower(title) LIKE ? OR lower(description) LIKE ?", "%#{search_term}%", "%#{search_term}%")
        else
          flash[:errors] = "Oops! We couldn't find your request."
        end
      end
    
      def show
      end
    
      def new
        @show = Show.new
      end
    
      def edit
      end
    
      def create
        @show = Show.new(show_params)
        if @show.save
          redirect_to admin_show_path(@show), notice: "Show was successfully created"
        else 
          render :new, status: :unprocessable_entity, notice:  "Unable to create/update show"
        end
      end
      
      def update
        if @show.update(show_params)
          redirect_to admin_show_path(@show), notice: "Show was successfully updated"
        else
          flash.now[:error] = @show.errors
          render :edit, status: :unprocessable_entity
        end
      end
     
      def destroy
        @show.booking.destroy_all
        @show.destroy!
        redirect_to admin_shows_path, notice: "'Show and associated bookings were successfully deleted.'"
      end
    
      def set_params_id
        @show = Show.find(params[:id])
      end
    
      def show_params
        params.require(:show).permit(:id, :show_time, :available_seates, :movie_id, :theatre_id, :price)
      end
  end
    
  