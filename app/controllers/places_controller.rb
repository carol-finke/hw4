class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
    @entries = @place.entries.where(user_id: session[:user_id])
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:notice] = "Place added successfully."
      redirect_to places_path
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end

  def require_login
    unless session[:user_id]
      flash[:notice] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end
end
