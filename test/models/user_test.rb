require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:john)
  end

  test 'first_name should be present' do
    @user.first_name = ''
    assert_not @user.valid?
  end

  test 'last_name should be present' do
    @user.last_name = ''
    assert_not @user.valid?
  end

  test 'subdomain should be present' do
    @user.subdomain = ''
    assert_not @user.valid?
  end

  test 'subdomain should be of valid format' do
    @user.subdomain = 'subdomain-' # not valid with dash at the end
    assert @user.valid?
    assert_equal 'subdomain', @user.subdomain # changed to withoud dash

    @user.subdomain = 'name-surname' # valid with dash in the middle
    assert @user.valid?
    assert_equal 'name-surname', @user.subdomain # not changed

    @user.subdomain = 'name--surname' # not valid with two dashes
    assert @user.valid?
    assert_equal 'name-surname', @user.subdomain # changed to one dash

    @user.subdomain = 'subdomain ' # space
    assert @user.valid?
    assert_equal 'subdomain', @user.subdomain # space removed

    @user.subdomain = 'a' * 64 # too long
    assert_not @user.valid?
  end
end
