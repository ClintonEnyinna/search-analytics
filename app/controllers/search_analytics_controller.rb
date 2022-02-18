class SearchAnalyticsController < ApplicationController
  before_action :logged_in?

  def show
    @latest_queries = SearchAnalytic.where(user: @current_user)
                                    .order(updated_at: :desc)

    @top_queries = SearchAnalytic.most_searched_query_sql(@current_user)
  end

  private

  def logged_in?
    redirect_to login_path if current_user.nil?
  end
end
