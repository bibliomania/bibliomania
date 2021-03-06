require 'coveralls'
Coveralls.wear!

require 'simplecov'

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module BetterAssertResponse
  def assert_response(*args)
    super
  rescue Minitest::Assertion => e
    if response.body.size < 200
      better_message = "#{e.message}\nResponse body: #{response.body}"
      raise Minitest::Assertion, better_message
    else
      raise
    end
  end
end
ActionDispatch::IntegrationTest.prepend(BetterAssertResponse)
