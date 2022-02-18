RSpec.describe SearchAnalytic, type: :model do
  it 'extends SearchAnalyticSql module' do
    expect(SearchAnalytic).to respond_to(:most_searched_query_sql)
  end

  describe 'association' do
    it { is_expected.to belong_to(:user) }
  end

  describe '#before_save' do
    let(:search_analytic) { create(:search_analytic, query: query) }
    let(:query) { Faker::Lorem.sentence.upcase }

    it 'saves the query in lowercase' do
      expect(search_analytic.query).to eq query.downcase
    end
  end
end
