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
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
