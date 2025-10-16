source "https://rubygems.org"

ruby "3.4.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0", ">= 8.0.3"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft", "~> 1.3", ">= 1.3.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.6", ">= 1.6.2"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 7.0", ">= 7.0.4"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.14", ">= 2.14.1"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache and Active Job
gem "solid_cache"
gem "solid_queue", "~> 1.2", ">= 1.2.1"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "~> 1.18", ">= 1.18.6", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", "~> 2.7", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", "~> 0.1.15", require: false

# Vite
gem "vite_rails", "~> 3.0", ">= 3.0.19"
gem "foreman", "~> 0.90.0"

# REST API client
gem "faraday", "~> 2.14"

# GraphQL
gem "graphql", "~> 2.5", ">= 2.5.14"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", "~> 1.11", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "~> 7.1", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # RSpec
  gem "rspec-rails", "~> 8.0", ">= 8.0.2"
  gem "shoulda-matchers", "~> 6.5"
  gem "database_cleaner-active_record", "~> 2.2", ">= 2.2.2"
  gem "webmock", "~> 3.25", ">= 3.25.1"
  gem "faker", "~> 3.5", ">= 3.5.2"
  gem "factory_bot_rails", "~> 6.5", ">= 6.5.1"
  gem "rspec-graphql_matchers"

  gem "byebug", "~> 12.0"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "graphiql-rails", "~> 1.10", ">= 1.10.5"
end
