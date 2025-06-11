# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# ① 標準 Logger を先に読み込む
require "logger"

# ② Bundler／Boot をセットアップ
require_relative "config/boot"

# ③ Rails コマンド／タスクを読み込む
require "rails/tasks"
require_relative "config/application"

Rails.application.load_tasks
