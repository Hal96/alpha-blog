class ArticlesController < ApplicationController
  before_action :set_articles , only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
    
  end

  def edit
    
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      #do something
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show 

  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was succesfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted "
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_articles
      @article = Article.find(params[:id])
    end

    def requiere_same_user
      if current_user != @article.user
        flash[:danger] = "You can only edit o delete your own articles"
        redirect_root_path
      end
    end

end
