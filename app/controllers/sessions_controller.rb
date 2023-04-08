class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p params[:session][:email]
    @user = User.find_by(email: params[:session][:email])
    puts "USER:"
    p @user
    if @user == nil
      flash[:notice] = "User not find"
      @user = User.new
      render "new"
      return
    end
    if @user.authenticate(params[:password])
      redirect_to articles_path
    else
      flash[:notice] = "Invalid pass"
      render "new"
    end
  end
end
