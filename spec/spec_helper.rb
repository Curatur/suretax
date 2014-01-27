require 'dotenv'  # First line of spec_helper
Dotenv.load       # Second line of spec_helper

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.bundle/'
end

require 'pry'
require 'rspec'
require 'suretax'
require 'awesome_print'
require 'webmock/rspec'

# Load support files
Dir[File.expand_path(File.dirname(__FILE__) + '/support/**/*.rb')].each do
  |support_file| require support_file
end

RSpec.configure do |config|

  config.before(:each) do
    Suretax.configure do |c|
      c.validation_key = ENV['SURETAX_VALIDATION_KEY']
      c.base_url = ENV['SURETAX_BASE_URL']
      c.client_number = ENV['SURETAX_CLIENT_NUMBER']
      c.post_path = ENV['SURETAX_POST_PATH']
      c.cancel_path = ENV['SURETAX_CANCEL_PATH']
    end
  end

end

# Silence deprecation warning from money/monetize libraries
I18n.enforce_available_locales = false

include RequestSpecHelper
include CancellationSpecHelper
include SuretaxSpecHelper
