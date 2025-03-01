# Blogging in Rainy Days

Rainy Days is a blog app by Ruby on Rails and Vue.js, and is a portfolio app to showcase how I code.

Rainy Days is a revised version of [Dainy Day Blog](https://gitlab.com/yokolet/rainy-day-blog).
The app had improvements, adjustments to run on newer version of Rails, and a new feature to dockerize.


On calm rainy days, surrounded by soft sound of pouring rain and feeling fresh air, people might enjoy blogging.
This is why the app is named like so.


### Key Technologies
- Ruby on Rails
- Vue.js
- OAuth2 Authorization code or PKCE by Google, GitHub, and GitLab
- GraphQL
- Docker

### Individual Technologies/Tools
- Ruby on Rails
  - PostgreSQL
  - RSPec
  - GraphQL Ruby
  - Vite Ruby
  - Docker
- Vue.js
  - Vite
  - Bun
  - Vue Router
  - Pinia
  - Vue Apollo
  - VueUse
  - Font Awesome
  - Tailwind CSS
  - TypeScript

### Versions
- Ruby 3.4.1
- Rails 8.0.1
- PostgreSQL 16.8
- Bun 1.2.1
- Vue.js 3.5.13

### How to Run the App

#### Prerequisite

Install below:
- Ruby [https://www.ruby-lang.org/en/](https://www.ruby-lang.org/en/)
- Bundler [https://bundler.io/](https://bundler.io/)
- PostgreSQL [https://www.postgresql.org/](https://www.postgresql.org/)
- Redis [https://redis.io/](https://redis.io/)
- Bun [https://bun.sh/](https://bun.sh/)

Setup OAuth 2 login:\
Create your own app at Google, GitHub, and GitLab for OAuth2 authentication.
For reference, URL(s) are listed below, but it's good to research by your own.
The ways of setup OAuth login are very different in each identity provider.
It might be confusing, so you'd better to look at multiple explanations.
Once the apps are created, get client id and client secret combinations.

- Google
  - Setting up OAuth 2.0: https://support.google.com/googleapi/answer/6158849?hl=en
  - Redirect URI: http://localhost:3906/auth/google/callback
- GitHub
  - Creating an OAuth app: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app
  - Redirect URI: http://localhost:3906/auth/github/callback
- GitLab
  - Configure GitLab as an OAuth 2.0 authentication identity provider: https://docs.gitlab.com/integration/oauth_provider/
  - Redirect URI: http://localhost:3906/auth/gitlab/callback

#### Source Code
Cline the repo:
```bash
$ git clone git@gitlab.com:yokolet/rainy-days.git
```

##### Install the App
```bash
$ cd rainy-day-blog
$ bundle install
$ rails db:prepare
$ bun install
```

##### Setup Credentials

Create credentials for three environments as in below:

```bash
$ rm config/master.key
$ rm config/credentials.yml.enc
$ EDITOR=vim rails credentials:edit --environment development
$ EDITOR=vim rails credentials:edit --environment test
$ EDITOR=vim rails credentials:edit --environment production
```

Each credentials files should have values below:
```yaml
secret_key_base:  YOUR_SECRET_KEY_BASE
# OAuth
oauth:
  google:
    redirect_uri: REDIRECT_URI_FOR_GOOGLE
    client_id: YOUR_GOOGLE_CLIENT_ID
    client_secret: YOUR_GOOGLE_CLIENT_SECRET
  github:
    redirect_uri: REDIRECT_URI_FOR_GITHUB
    client_id: YOUR_GITHUB_CLIENT_ID
    client_secret: YOUR_CLIENT_SECRET
  gitlab:
    redirect_uri: REDIRECT_URI_FOR_GITLAB
    client_id: YOUR_GITLAB_CLIENT_ID
    client_secret: YOUR_GITLAB_CIENT_SECRET
```

To generate a value for secret_key_base, try blow:

```bash
$ bin/rails secret
```

Then, copy & paste the value to credentials file.


#### Run the app in development environment

The command below is used for development and starts Rails and vite servers.

```bash
$ bin/dev
```

Once, the servers start successfully, go to http://localhost:3906


#### Run the app in production environment

When the app runs without SSL in production environment,
set two config parameters to false in `config/environments/production.rb`:

```ruby
config.assume_ssl = false
config.force_ssl = false
```

Then, precompile assets:

```bash
$ RAILS_ENV=production rails assets:precompile
```

Start the app　as in below:

```bash
$ RAILS_ENV=production rails s -p 3906
```

If you change the port number:
- Change the port number of redirect URI at identity providers: Google, GitHub and GitLab
- Change the redirect URIs in credentials files: config/credentials/[development|poduction|test].yml.enc

#### Run the app in Docker

Create `.env` file with the content below:
```bash
DB_HOST=db
DB_USERNAME=postgres
DB_PASSWORD=postgres
```

Create a docker image:
```bash
RAILS_MASTER_KEY=`cat config/credentials/production.key` docker compose up --build
```

Once the docker image is created, the app starts running.
Go to http://localhost:3906

### Run Test
```bash
$ bundle exec rspec
```
