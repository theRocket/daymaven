require File.expand_path('../boot', __FILE__)

# use syck instead of psych (Win) because of issues with merging syntax, i.e. <<: *common
#YAML::ENGINE.yamler = 'syck'

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Daymaven
  class Application < Rails::Application
    # Added by the Rails 3 jQuery Template
    # http://github.com/lleger/Rails-3-jQuery, written by Logan Leger
    config.action_view.javascript_expansions[:defaults] = %w(rails)
    config.action_view.javascript_expansions[:cdn] = %w(https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js rails)
    config.action_view.javascript_expansions[:gmaps] = %w(http://maps.google.com/maps?file=api&v=3&key=s&sensor=false&key=ABQIAAAAnlzUvzCoMlSC-rAYXxLPbhR571c-r_cMBqJF57lhLDKElNB3_xQ05nTyDOnRX6zOHqMNnUp2L15fGg)
    #config.action_view.javascript_expansions[:freebase] = %w(http://freebaselibs.com/static/suggest/1.3/suggest.min.js)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
