require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module DefiUnchainedApi
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true

    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.skip_routes true
      generate.routing_specs false
      generate.controller_specs false
      generate.request_specs false
    end

    config.stripe.publishable_key = Rails.application.credentials.stripe[:publishable_key]
    config.stripe.secret_key = Rails.application.credentials.stripe[:secret_key]
  end
end
