ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login
    #post session_url, controller: sessions, email: 'smclean17@gmail.com', password: 'testpassword'
    account = accounts(:one)
    session[:account_id] = account.id
  end
end
class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  def user_login
    visit login_url
    within("//form[@id='login']") do
      fill_in 'Email', with: 'smclean17@gmail.com'
      fill_in 'Password', with: 'testpassword'
      click_button 'Login'
    end
    assert has_content? 'Sally Mclean'
  end
end
