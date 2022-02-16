class CreateSearchAnalytics < ActiveRecord::Migration[6.1]
  def change
    create_table :search_analytics do |t|
      t.text :query, null: false, default: ""

      t.timestamps
    end
  end
end
