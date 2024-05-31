class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = BCrypt::Password.create(params[:user][:password])
    if @user.save
      flash[:notice] = "Thanks for signing up. Now login."
      redirect_to login_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
