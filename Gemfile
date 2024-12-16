source "https://rubygems.org"

# CORE
gem "bootsnap", require: false
gem "rails", "~> 8.0.1"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "dotenv-rails"

# REQUESTS
gem "grape", "~> 2.2"
# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false
gem "rack-cors"

# EXTENSIONS
gem "bcrypt", "~> 3.1.7"
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# DEPLOY
gem "kamal", require: false # https://kamal-deploy.org

gem "random_name_generator"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
gem "vite_rails", "< 4.0.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  gem "rubocop-rspec"
  gem "rubocop-faker"
  gem "rubocop-performance"
  gem "rubocop-thread_safety"

  gem "rspec"
  gem "faker"
  gem "factory_bot"
end
