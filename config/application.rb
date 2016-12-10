require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module MailFunnelClient
  class Application < Rails::Application
    config.action_dispatch.default_headers = {
       'X-Frame-Options' => 'ALLOWALL'
    }

    config.middleware.use, Rack::JWT::Auth,

    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths << "#{Rails.root}/lib"

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :test_unit, fixture: true
        g.stylesheets     false
        g.javascripts     false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
