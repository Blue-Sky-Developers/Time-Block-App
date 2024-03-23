# app_test.rb

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require_relative 'app'  # Assuming your main Sinatra app is in the same directory

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_welcome_page
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, '<h1>Welcome to Our Organization!</h1>'
  end
end
