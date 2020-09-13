require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HouseholdAccountOnRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # バリデーションメッセージの日本語化
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    # mount_uploaderでuninitialized constantエラーが出るのを回避
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    # 週の開始曜日
    config.beginning_of_week = :sunday
    # タイムゾーン
    config.time_zone = 'Tokyo'
    # 部分的にアプリケーションを読み込む。Herokuデプロイ時に必要。
    config.assets.initialize_on_precompile = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  
  end
end
