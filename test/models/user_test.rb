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
    @user.subdomain = 'subdomain-'
    assert @user.valid?
    assert_equal 'subdomain', @user.subdomain

    @user.subdomain = 'subdomain '
    assert @user.valid?
    assert_equal 'subdomain', @user.subdomain
  end
end
