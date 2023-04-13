class ArticlesController < ApplicationController

  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_author, only: [:edit, :destroy, :update]

  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 2)
  end

  def show
  end

  def new
    @article = Article.new()
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully"
      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  def edit
    puts "hello world render edit"
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_author
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can't edit artworks other than yours"
      redirect @article
    end
  end

end
