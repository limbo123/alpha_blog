class UsersController < ApplicationController
  before_action :define_user, only: [:new]
  before_action :find_user_by_id, only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 2)
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User was successfully created. #{@user.username}, Welcome to the Alpha Blog"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfuly edited"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def define_user
    @user = User.new
  end

  def find_user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
