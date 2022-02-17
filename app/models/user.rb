class User < ApplicationRecord
  has_many :search_analytics

  validates :name, :email, presence: true
end
