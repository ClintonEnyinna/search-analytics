class ArticlesController < ApplicationController
  before_action :logged_in?

  def index
    initialize_redis_key

    @articles = Article.all
  end

  def search
    if params[:search].present?
      @articles = Article.pg_search(params[:search])
    else
      @articles = Article.all
    end

    track_search(params[:search])

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

  def logged_in?
    redirect_to login_path if current_user.nil?
  end

  def initialize_redis_key
    $redis.set("query:user:#{@current_user.id}", '')
  end
end
