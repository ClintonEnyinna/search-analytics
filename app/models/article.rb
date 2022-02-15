class Article < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :pg_search, 
                  against: {
                    title: 'A',
                    author: 'B',
                    body: 'C',
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  validates :title, :author, :body, presence: true
end
