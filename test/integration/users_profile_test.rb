require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @admin = users(:michael)
    @nonadmin = users(:archer)
  end

  test "profile display of other user for non-logged in user" do
    get user_path(@admin)
    assert_redirected_to root_url
  end
  
  test "profile display of other user for nonadmin logged in user" do
    log_in_as(@nonadmin)
    get user_path(@admin)
    assert_redirected_to root_url
  end

  test "profile display of other user for admin user" do
    log_in_as(@admin)
    get user_path(@nonadmin)
    assert_template 'users/show'
    assert_select 'title', full_title(@nonadmin.name)
    assert_select 'h1', text: @nonadmin.name
    assert_select 'h1>img.gravatar'
  end
end
