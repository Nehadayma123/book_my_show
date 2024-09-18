module Admin
  class MoviesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_params_id, only: %i[show edit update destroy]
    PER_PAGE = 8

    def index
      @distinct_locations = Theatre.select(:location).distinct.pluck(:location)
      selected_location = params[:location]
      @page = params[:page].to_i > 0 ? params[:page].to_i : 1
      @total_movies = Movie.count
      if params[:language].present?
        @movies =
          Movie
            .where('LOWER(language) = ?', params[:language].downcase)
            .order(created_at: :desc)
            .limit(PER_PAGE)
            .offset((@page - 1) * PER_PAGE)
        @total_movies =
          Movie.where('LOWER(language) = ?', params[:language].downcase).count
      elsif params[:title_search].present?
        search_term = params[:title_search].downcase
        @movies =
          Movie
            .where(
              'lower(title) LIKE ? OR lower(description) LIKE ?',
              "%#{search_term}%",
              "%#{search_term}%",
            )
            .order(created_at: :desc)
            .limit(PER_PAGE)
            .offset((@page - 1) * PER_PAGE)
        @total_movies =
          Movie.where(
            'lower(title) LIKE ? OR lower(description) LIKE ?',
            "%#{search_term}%",
            "%#{search_term}%",
          ).count
      elsif selected_location.present?
        @theatres_in_location = Theatre.where(location: selected_location)
        @movies =
          Movie
            .joins(:shows)
            .where(shows: { theatre: @theatres_in_location })
            .distinct
      else
        @movies =
          Movie
            .order(created_at: :desc)
            .limit(PER_PAGE)
            .offset((@page - 1) * PER_PAGE)
      end
      @total_pages = (@total_movies / PER_PAGE.to_f).ceil
    end

    def search
      if params[:title_search].present?
        search_term = params[:title_search].downcase
        @movies =
          Movie.where(
            'lower(title) LIKE ? OR lower(description) LIKE ?',
            "%#{search_term}%",
            "%#{search_term}%",
          )
      else
        flash[:errors] = "Oops! We couldn't find your request."
      end
    end

    def show; end

    def new
      @movie = Movie.new
    end

    def edit; end

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        redirect_to admin_movies_path(@movie),
                    notice: 'Movie was successfully created'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @movie.update(movie_params)
        redirect_to admin_movies_path(@movie),
                    notice: 'Movie was successfully updated'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @movie.destroy!
      redirect_to admin_movies_path, notice: 'Movie was sucessfully destroy.'
    end

    def set_params_id
      @movie = Movie.find(params[:id])
      redirect_to admin_movies_path, alert: 'Movie not found.' if @movie.nil?
    end

    def movie_params
      params
        .require(:movie)
        .permit(:id, :title, :description, :language, :image)
    end
  end
end
