ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup"  # Set up gems listed in the Gemfile

# bootsnap は開発／テスト環境のみ有効化
environment = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
if %w[development test].include?(environment)
  require "bootsnap/setup"  # Speed up boot time by caching expensive operations
end