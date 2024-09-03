class TheatresController < ApplicationController
  before_action :set_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @theatres = Theatre.all
  end

  def show
  end

  def edit
  end

  def new
    @theatre = Theatre.new
  end

  def create
    @theatre = Theatre.new(theatre_params)
    if @theatre.save
      redirect_to @theatre, notice: "Theatre was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @theatre.update(theatre_params)
      redirect_to  @theatre, notice: "Theatre was successfully updated"
    else
      render :edit
    end
  end
  
  def destroy
    @theatre.destroy!
    redirect_to theatres_path, notice: "Theatre was sucessfully destroy."
  end

  def set_params_id
    @theatre = Theatre.find(params[:id])
  end
  
  def theatre_params
    params.require(:theatre).permit(:id, :name, :location)
  end
end
