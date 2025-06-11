require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 本番環境ではコードはリロードされず、キャッシュされます
  config.cache_classes = true

  # アプリ起動時にコードを全て読み込む
  config.eager_load = true

  # エラー詳細は表示せず、キャッシュを有効化
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # master.key を必須にしない（Heroku用）
  # config.require_master_key = true

  # Heroku環境変数で静的ファイルを提供する
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # CSS/JSなどが precompile されていないときでも読み込めるようにする
  config.assets.compile = true

  # アップロードファイルの保存先（ローカル）
  config.active_storage.service = :local

  # HTTPS強制（商用時のみ有効化）
  # config.force_ssl = true

  # ログレベル設定
  config.log_level = :info
  config.log_tags = [ :request_id ]

  # キャッシュストア（必要があれば変更）
  # config.cache_store = :mem_cache_store

  # Active Job のバックエンド設定（未使用ならコメントのままでOK）
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "your_app_production"

  config.action_mailer.perform_caching = false

  # メール送信エラーを無視（開発段階ならそのままでOK）
  # config.action_mailer.raise_delivery_errors = false

  # I18n のフォールバックを有効化（翻訳がなければデフォルト言語）
  config.i18n.fallbacks = true

  # 非推奨警告をログに表示しない
  config.active_support.report_deprecations = false

  # デフォルトのログフォーマットを使用
  config.log_formatter = ::Logger::Formatter.new

  # STDOUT ログ（Herokuで有効）
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # マイグレーション後に schema.rb をダンプしない
  config.active_record.dump_schema_after_migration = false
end
