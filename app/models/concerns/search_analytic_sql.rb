module SearchAnalyticSql
  def most_searched_query_sql(user)
    sql = <<~SQL
      SELECT query, COUNT(id)
      FROM search_analytics
      WHERE user_id = #{user.id}
      GROUP BY query
      ORDER BY COUNT(id) DESC;
    SQL

    ActiveRecord::Base.connection.execute(sql)
  end
end
