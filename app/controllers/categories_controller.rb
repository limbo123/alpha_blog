class CategoriesController < ApplicationController
  # before_action :require_user, except: [:index, :show]
  before_action :find_category_by_id, only: [:show]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(name: params[:category][:name])

    if @category.save
      flash[:notice] = "Category '#{@category.name}' was created successfully"
      redirect_to @category
    else
      render "new"
    end
  end

  private

  def find_category_by_id
    @category = Category.find(params[:id])
  end
end
