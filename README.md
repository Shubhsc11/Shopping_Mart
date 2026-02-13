# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)


* Deployment instructions

## Deploying to Render

1. [Sign up](https://dashboard.render.com/register) for a Render account if you don't have one.
2. Connect your GitHub repository to Render.
3. Render will auto-detect the Rails app. Use the following settings:
	- **Build Command:** `bundle install && bundle exec rake db:migrate`
	- **Start Command:** `bundle exec rails server -p 10000`
4. Add the following environment variables in Render:
	- `RAILS_MASTER_KEY` (from your local `config/master.key`)
	- `DATABASE_URL` (auto-provided if you add a Render Postgres service)
5. Add a Postgres database via Render and link it to your web service.
6. Deploy!

See `render.yaml` for an example Render Blueprint configuration.

* ...
