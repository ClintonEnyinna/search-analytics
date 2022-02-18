RSpec.describe SearchAnalyticsController, type: :controller do
  describe 'routes' do
    it { is_expected.to route(:get, 'search_analytic').to(action: :show) }
  end

  describe '#show' do
    let(:user) { create(:user) }

    context 'when logged in' do
      before { session[:email] = user.email }

      it 'renders the show template with status 200' do
        get :show

        expect(response).to render_template(:show)
        expect(response).to have_http_status(200)
      end
    end

    context 'when not logged in' do
      it 'redirects to the login page' do
        get :show

        expect(response).to redirect_to(login_path)
        expect(response).to have_http_status(302)
      end
    end
  end
end
