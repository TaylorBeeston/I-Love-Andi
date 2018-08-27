require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @unactivated = users(:plebian)
  end
  
  test "index as admin inculding pagination and delete links" do
    log_in_as @admin
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1).each do |user|
      if user.activated?
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      else
        assert_select 'a[href=?]', user_path(user), count: 0
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
  
  test "index as non-admin" do
    log_in_as @non_admin
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
  
  test "cannot view unactivated users" do
    log_in_as @admin
    get user_path(@unactivated)
    follow_redirect!
    assert_template root_path
  end
  
  test "search for a user" do
    log_in_as @admin
    get users_path, params: { susers: "Michael" }
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@admin), text: "Michael Example"
    assert_select 'a[href=?]', user_path(@non_admin), count: 0
  end
end
