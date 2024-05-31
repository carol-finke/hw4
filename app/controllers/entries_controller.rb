class EntriesController < ApplicationController
  before_action :require_login
  before_action :set_place

  def index
    @entries = @place.entries.where(user_id: session[:user_id])
  end

  def new
    @entry = @place.entries.new
  end

  def create
    @entry = @place.entries.new(entry_params)
    @entry.user_id = session[:user_id]
    if @entry.save
      flash[:notice] = "Entry added successfully."
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on)
  end

  def require_login
    unless session[:user_id]
      flash[:notice] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end
end
