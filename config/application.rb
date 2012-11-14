require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module ImgSeek
  class Application < Rails::Application
    
    config.autoload_paths += %W(#{config.root}/lib)

    config.time_zone = 'Beijing'

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    
    config.i18n.default_locale = "zh-CN"
    
    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.active_support.escape_html_entities_in_json = true

    config.active_record.whitelist_attributes = true

    config.assets.enabled = true

    config.assets.version = '1.0'
  end
end
