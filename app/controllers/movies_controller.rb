class MoviesController < ApplicationController
  before_action :set_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  def destroy
    @movie.destroy!
    redirect_to theatres_path, notice: "Theatre was sucessfully destroy."
  end

  def set_params_id
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:id, :title, :description)
  end

end
