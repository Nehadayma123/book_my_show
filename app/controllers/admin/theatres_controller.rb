class Admin::TheatresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params_id, only: %i[show edit update destroy]
  PER_PAGE = 5
  def index
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @total_theatres = Theatre.count
    @theatres =
      Theatre
        .order(created_at: :desc)
        .limit(PER_PAGE)
        .offset((@page - 1) * PER_PAGE)

    @total_pages = (@total_theatres / PER_PAGE.to_f).ceil
  end

  def search
    if params[:title_search].present?
      search_term = params[:title_search].downcase
      @theatres =
        Theatre.where(
          'lower(name) LIKE ? OR lower(location) LIKE ?',
          "%#{search_term}%",
          "%#{search_term}%",
        )
    else
      flash[:errors] = "Oops! We couldn't find your request."
    end
  end

  def show; end

  def edit; end

  def new
    @theatre = Theatre.new
  end

  def create
    @theatre = Theatre.new(theatre_params)
    if @theatre.save
      redirect_to admin_theatre_path(@theatre),
                  notice: 'Theatre was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @theatre.update(theatre_params)
      redirect_to admin_theatre_path, notice: 'Theatre was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @theatre.destroy!
    redirect_to admin_theatres_path, notice: 'Theatre was sucessfully destroy.'
  end

  def set_params_id
    @theatre = Theatre.find(params[:id])
  end

  def theatre_params
    params.require(:theatre).permit(:id, :name, :location)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
