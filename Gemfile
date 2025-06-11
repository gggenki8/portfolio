source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.8"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "devise"
gem "rails-i18n"
gem "bigdecimal"
gem "mutex_m"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "sassc-rails"
gem "importmap-rails"
gem "image_processing", '~> 1.2'

# 本番環境用 PostgreSQL
group :production do
  gem "pg"
end

# 開発・テスト環境用 SQLite と開発用gem
group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "bootsnap", require: false
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", '~> 5.0'
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  # gem "rack-mini-profiler"
  # gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "database_cleaner-active_record"
  gem "shoulda-matchers", '~> 5.0'
end
