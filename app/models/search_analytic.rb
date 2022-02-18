class SearchAnalytic < ApplicationRecord
  belongs_to :user

  before_save { query.downcase! }
end
