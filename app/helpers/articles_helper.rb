module ArticlesHelper
  def track_search(query)
    last_searched_query = $redis.get("query:user:#{@current_user.id}") ||
                           SearchAnalytic.where(user_id: @current_user.id).last.query

    query = query.downcase
    last_searched_query = last_searched_query.downcase

    # prevent logging query when words are being deleted with the backspace key
    return if query.present? && last_searched_query.include?(query)

    $redis.set("query:user:#{@current_user.id}", query)
    $redis.expire("query:user:#{@current_user.id}", 2.hours.to_i)

    log_data(query, last_searched_query)
  end

  def log_data(query, last_searched_query)
    if query.include?(last_searched_query)
      UpdateSearchAnalyticJob.perform_later(query, @current_user.id)
    else
      CreateSearchAnalyticJob.perform_later(query, @current_user.id)
    end
  end
end
