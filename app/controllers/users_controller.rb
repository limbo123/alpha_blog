class UsersController < ApplicationController
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :define_user, only: [:new]
  before_action :find_user_by_id, only: [:edit, :update, :show, :destroy]
  before_action :require_author , only: [:edit, :update, :destroy]

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

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    redirect_to root_path
  end

  private

  def define_user
    @user = User.new
  end

  def require_author
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can't edit or delete foreign accounts"
      redirect_to @user
    end
  end

  def find_user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
