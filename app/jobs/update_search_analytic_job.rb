class UpdateSearchAnalyticJob < ApplicationJob
  queue_as :default

  def perform(query, user_id)
    SearchAnalytic.where(user_id: user_id).last.update!(query: query)
  end
end
