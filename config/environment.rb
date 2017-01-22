# Load the Rails application.
require_relative 'application'

Rails.application.config.session_store :cookie_store, :key => '_rails5_bdostats_app_session', :domain => '.bdostats.com'
# Initialize the Rails application.
Rails.application.initialize!
