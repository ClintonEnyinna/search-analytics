class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    if params[:search].present?
      @articles = Article.pg_search(params[:search])
    else
      @articles = Article.all
    end

    render :search, layout: false
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :author, :body)
  end
end
