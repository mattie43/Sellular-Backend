# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.routes.default_url_options[:host] = 'http://192.168.1.201:3000' # http://192.168.1.201:3000 || localhost:3000