RSpec.describe SessionsController, type: :controller do
  describe 'routes' do
    it { is_expected.to route(:get, 'login').to(action: :new) }
    it { is_expected.to route(:post, 'login').to(action: :create) }
    it { is_expected.to route(:delete, 'logout').to(action: :destroy) }
  end

  describe '#new' do
    it 'renders the new template with status 200' do
      get :new

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    let(:user) { create(:user) }

    it 'logs in user and redirects to root' do
      post :create, params: { session: { email: user.email } }

      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(302)
      expect(session[:email]).to eq(user.email)
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    before { session[:email] = user.email }

    it 'logs out the current user and redirects to root' do
      delete :destroy

      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(302)
      expect(session[:email]).to be_nil
    end
  end
end
