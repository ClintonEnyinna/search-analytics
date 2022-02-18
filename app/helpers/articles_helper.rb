module ArticlesHelper
  def track_search(query)
    return $redis.set("query:user:#{@current_user.id}", '') if query.blank?

    last_searched_query = $redis.get("query:user:#{@current_user.id}") ||
                          last_searched_query_from_db

    query.downcase!
    last_searched_query.downcase!

    # prevent logging query when words are being deleted with the backspace key
    return if last_searched_query.include?(query)

    $redis.set("query:user:#{@current_user.id}", query)

    log_data(query, last_searched_query)
  end

  def log_data(query, last_searched_query)
    if last_searched_query == '' || !query.include?(last_searched_query)
      CreateSearchAnalyticJob.perform_later(query, @current_user.id)
    else
      UpdateSearchAnalyticJob.perform_later(query, @current_user.id)
    end
  end

  def last_searched_query_from_db
    SearchAnalytic.where(user: @current_user).last.query
  end
end
