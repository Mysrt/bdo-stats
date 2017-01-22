# Load the Rails application.
require_relative 'application'

Rails3App::Application.config.session_store :cookie_store, :key => '_rails5_bdostats_app_session', :domain => :all
# Initialize the Rails application.
Rails.application.initialize!
