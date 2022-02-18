RSpec.describe ArticlesController, type: :controller do
  ActiveJob::Base.queue_adapter = :test

  describe 'routes' do
    it { is_expected.to route(:get, root_path).to(action: :index) }
    it { is_expected.to route(:get, new_article_path).to(action: :new) }
    it { is_expected.to route(:post, articles_path).to(action: :create) }
    it { is_expected.to route(:get, search_articles_path).to(action: :search) }
  end

  describe '#index' do
    let(:user) { create(:user) }

    context 'when logged in' do
      before { session[:email] = user.email }

      it 'renders the index template with status 200' do
        get :index

        expect(response).to render_template(:index)
        expect(response).to have_http_status(200)
      end

      it 'sets the redis key to an empty string' do
        get :index

        expect($redis.get("query:user:#{user.id}")).to eq ''
      end
    end

    context 'when not logged in' do
      it 'redirects to the login page' do
        get :index

        expect(response).to redirect_to(login_path)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe '#search' do
    let(:user) { create(:user) }

    context 'when logged in' do
      before { session[:email] = user.email }

      context 'when param is empty' do
        it 'renders the search template with status 200' do
          expect { get :search }.to change(SearchAnalytic, :count).by(0)

          expect(response).to render_template(:search)
          expect(response).to have_http_status(200)
        end

        it 'sets the redis key to an empty string' do
          get :search

          expect($redis.get("query:user:#{user.id}")).to eq ''
        end

        it 'renders the search template with status 200' do
          get :search

          expect(response).to render_template(:search)
          expect(response).to have_http_status(200)
        end
      end

      context 'when new search' do
        let(:search) { Faker::Lorem.sentence }

        before { $redis.set("query:user:#{user.id}", '') }

        it 'enqueues CreateSearchAnalyticJob job' do
          expect { get :search, params: { search: search } }
            .to have_enqueued_job(CreateSearchAnalyticJob)
        end

        it 'sets the redis key to last saved search' do
          get :search, params: { search: search }

          expect($redis.get("query:user:#{user.id}")).to eq search.downcase
        end

        it 'renders the search template with status 200' do
          get :search, params: { search: search }

          expect(response).to render_template(:search)
          expect(response).to have_http_status(200)
        end
      end

      context 'when param is a superset of last saved search' do
        let(:search) { search_analytic.query + Faker::Lorem.sentence }
        let(:search_analytic) { create(:search_analytic, user: user) }

        it 'enqueues UpdateSearchAnalyticJob job' do
          expect { get :search, params: { search: search } }
            .to have_enqueued_job(UpdateSearchAnalyticJob)
        end

        it 'sets the redis key to last saved search' do
          get :search, params: { search: search }

          expect($redis.get("query:user:#{user.id}")).to eq search.downcase
        end

        it 'renders the search template with status 200' do
          get :search, params: { search: search }

          expect(response).to render_template(:search)
          expect(response).to have_http_status(200)
        end
      end

      context 'when param is a subset of last saved search' do
        let(:search) { search_analytic.query[0..(search_analytic.query.length / 2)] }
        let(:search_analytic) { create(:search_analytic, user: user) }

        it 'does not enqueue UpdateSearchAnalyticJob' do
          expect { get :search, params: { search: search } }
            .not_to have_enqueued_job(UpdateSearchAnalyticJob)
        end

        it 'does not enqueue CreateSearchAnalyticJob' do
          expect { get :search, params: { search: search } }
            .not_to have_enqueued_job(CreateSearchAnalyticJob)
        end

        it 'renders the search template with status 200' do
          get :search, params: { search: search }

          expect(response).to render_template(:search)
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe '#new' do
    let(:user) { create(:user) }

    context 'when logged in' do
      before { session[:email] = user.email }

      it 'renders the new template with status 200' do
        get :new

        expect(response).to render_template(:new)
        expect(response).to have_http_status(200)
      end
    end

    context 'when not logged in' do
      it 'redirects to the login page' do
        get :new

        expect(response).to redirect_to(login_path)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe '#create' do
    let(:author) { Faker::Name.name }
    let(:body) { Faker::Lorem.sentence }
    let(:title) { Faker::Lorem.sentence }

    context 'when logged in' do
      let(:user) { create(:user) }

      before { session[:email] = user.email }

      it 'creates a new user, logins the user and redirects to root' do
        expect { post :create, params: { article: { title: title, author: author, body: body } } }
          .to change(Article, :count).by(1)

        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        expect(Article.last).to have_attributes(author: author, title: title, body: body)
      end
    end

    context 'when not logged in' do
      it 'redirects to the login page and does not create a new article' do
        expect { post :create, params: { article: { title: title, author: author, body: body } } }
          .to change(Article, :count).by(0)

        expect(response).to redirect_to(login_path)
        expect(response).to have_http_status(302)
      end
    end
  end
end
