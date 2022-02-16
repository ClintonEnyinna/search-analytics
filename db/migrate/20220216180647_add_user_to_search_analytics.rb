class AddUserToSearchAnalytics < ActiveRecord::Migration[6.1]
  def change
    add_reference :search_analytics, :user, index: true, foreign_key: true
  end
end
