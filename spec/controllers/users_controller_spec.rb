RSpec.describe UsersController, type: :controller do
  describe 'routes' do
    it { is_expected.to route(:get, new_user_path).to(action: :new) }
    it { is_expected.to route(:post, users_path).to(action: :create) }
  end

  describe '#new' do
    it 'renders the new template with status 200' do
      get :new

      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    let(:email) { Faker::Internet.email }

    it 'creates a new user, logins the user and redirects to root' do
      expect { post :create, params: { user: { name: 'test', email: email } } }.to change(User, :count).by(1)

      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(302)
      expect(session[:email]).to eq(email)
    end
  end
end
