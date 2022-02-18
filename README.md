Search Analytics
================

Online articles app with search and analytics.

## What it does?
Users can create a new article, search in real-time and see insights on their frequent and latest searches.

### Prerequisites
- Ruby: 2.7.4
- Rails: 6.1.4.6

## Built with
* [pg_search](https://github.com/Casecommons/pg_search) - Search Engine that takes advantage of PostgreSQL's full text search.
* [Chartkick](https://chartkick.com/) - Charts
* [Sidekiq](https://github.com/mperham/sidekiq) - Sidekiq
* [Redis](https://github.com/redis/redis-rb) - Redis db
* [Rails](https://rubyonrails.org/) - Framework 
* [Ruby](https://www.ruby-lang.org/en/) - Programming language used
* [VS Code](https://code.visualstudio.com/) - The code editor used

## Live Version 🌟
* https://search-analytic-articles.herokuapp.com

## Local
### Step 1: Clone and install dependencies
- Clone the repo and run `bundle install` to get all the gems on your terminal.
### Step 2: Run database migration
- From terminal type `rails db:create` and then `rails db:migrate` to get your schema updated
### Step 3: Work on IRB
- Start redis server `redis-server` and sidekiq `bundle exec sidekiq`
- Start the server `rails server` and open your browser
### Step 4: View your app
- Navigate to `localhost:3000` on your browser to see your app working.
