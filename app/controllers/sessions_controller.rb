class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p params[:session][:email]
    @user = User.find_by(email: params[:session][:email])
    puts "USER:"
    p params[:password]
    if @user == nil
      flash[:notice] = "User not find"
      @user = User.new
      render "new"
      return
    end
    if @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Invalid pass"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You was logged out successfully"
    redirect_to root_path
  end
end
