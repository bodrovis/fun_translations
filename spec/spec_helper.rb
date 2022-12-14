# frozen_string_literal: true

require 'simplecov'
require 'webmock/rspec'

SimpleCov.start do
  add_filter 'spec/'
  add_filter '.github/'
end

if ENV.fetch('CI', nil) == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'fun_translations'

# Support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include TestClient
end
