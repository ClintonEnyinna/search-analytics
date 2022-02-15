class Article < ApplicationRecord
  validates :title, :author, :body, presence: true
end
