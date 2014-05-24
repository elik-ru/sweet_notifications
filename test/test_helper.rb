ENV['RAILS_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'sweet_notifications'
require 'active_support/test_case'
require 'securerandom'

class ActiveSupport::TestCase
  class << self
    remove_method :describe
  end

  extend MiniTest::Spec::DSL
  register_spec_type /ControllerRuntime$/, ActionController::TestCase
  register_spec_type self
end

module ActionController
  TestRoutes = ActionDispatch::Routing::RouteSet.new
  TestRoutes.draw do
    match ':controller(/:action)', via: [:all]
  end

  class Base
    include ActionController::Testing
    include TestRoutes.url_helpers
  end

  class ActionController::TestCase
    setup do
      @routes = TestRoutes
    end
  end
end
