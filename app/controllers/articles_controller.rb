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

  def track_search(query)
    return if query.nil?

    last_search = SearchAnalytic.last

    return if query.present? && last_search.query.include?(query)

    if query.downcase.include?(last_search.query.downcase)
      last_search.update!(query: query)
    else
      SearchAnalytic.create!(query: query)
    end
  end
end
