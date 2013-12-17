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
require 'vcr'

# Load support files
Dir[File.expand_path(File.dirname(__FILE__) + '/support/**/*.rb')].each do
  |support_file| require support_file
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|

  config.before(:each) do
    Suretax.configure do |c|
      c.validation_key = ENV['SURETAX_VALIDATION_KEY']
      c.base_url = ENV['SURETAX_BASE_URL']
    end
  end

end

include RequestSpecHelper
include SuretaxSpecHelper
