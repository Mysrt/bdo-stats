# Load the Rails application.
require_relative 'application'

BdoStats::Application.config.session_store :cookie_store, key: '_rails5_bdostats_app_session', domain: :all, tld_length: 2
# Initialize the Rails application.
Rails.application.initialize!
