class Admin::ShowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params_id, only: %i[show edit update destroy]
  PER_PAGE = 10
  def show_theatre
    @theatres = Theatre.all

    @movie = Movie.find(params[:movie_id])

    selected_date =
      params[:date].present? ? Date.parse(params[:date]) : Time.zone.now.to_date

    now = Time.zone.now
    ten_minutes_from_now = now + 10.minutes

    @shows =
      Show
        .where(
          movie: @movie,
          show_time: selected_date.beginning_of_day..selected_date.end_of_day,
        )
        .order(:show_time)
  end

  def index
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @total_shows = Show.count
    @shows =
      Show
        .order(created_at: :desc)
        .limit(PER_PAGE)
        .offset((@page - 1) * PER_PAGE)

    @total_pages = (@total_shows / PER_PAGE.to_f).ceil
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
    @show = Show.new
  end

  def edit; end

  def create
    @show = Show.new(show_params)
    if @show.save
      redirect_to admin_show_path(@show),
                  notice: 'Show was successfully created'
    else
      render :new,
             status: :unprocessable_entity,
             notice: 'Unable to create/update show'
    end
  end

  def update
    if @show.update(show_params)
      redirect_to admin_show_path(@show),
                  notice: 'Show was successfully updated'
    else
      flash.now[:error] = @show.errors
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @show.booking.destroy_all
    @show.destroy!
    redirect_to admin_shows_path,
                notice:
                  'Show and associated bookings were successfully deleted.'
  end

  def set_params_id
    @show = Show.find(params[:id])
  end

  def show_params
    params
      .require(:show)
      .permit(
        :id,
        :show_time,
        :available_seates,
        :movie_id,
        :theatre_id,
        :price,
      )
  end
end
