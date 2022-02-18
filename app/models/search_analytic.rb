class SearchAnalytic < ApplicationRecord
  extend SearchAnalyticSql

  belongs_to :user

  before_save { query.downcase! }
end
