ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

if RUBY_VERSION >= "2.6.0" && Rails.version < "5"
  class ActionController::TestResponse < ActionDispatch::TestResponse
    def recycle!
      @mon_mutex_owner_object_id = nil
      @mon_mutex = nil
      initialize
    end
  end
end
