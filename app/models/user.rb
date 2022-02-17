class User < ApplicationRecord
  has_many :search_analytics

  validates :name, :email, presence: true

  after_create :default_search_analytic

  private

  def default_search_analytic
    SearchAnalytic.create!(query: "", user: self)
  end
end
