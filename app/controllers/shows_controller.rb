class ShowsController < ApplicationController
  
    before_action :set_params_id, only: [:show, :edit, :update, :destroy]
  
    def index
      @shows = Show.all
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
        redirect_to @show, notice: "Show was successfully created"
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def update
      if @show.update(show_params)
        redirect_to @show, notice: "Show was successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end
   
    def destroy
      @show.destroy!
      redirect_to shows_path, notice: "Show was sucessfully destroy."
    end
  
    def set_params_id
      @show = Show.find(params[:id])
    end
  
    def show_params
      params.require(:show).permit(:id, :show_time, :available_seates)
    end
end
  
