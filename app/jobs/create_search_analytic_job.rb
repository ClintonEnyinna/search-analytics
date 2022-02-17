class CreateSearchAnalyticJob < ApplicationJob
  queue_as :default

  def perform(query, user_id)
    SearchAnalytic.create!(query: query, user_id: user_id)
  end
end
