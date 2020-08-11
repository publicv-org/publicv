require 'test_helper'

class CvsHelperTest < ActionView::TestCase
  setup do
    @started_on = Date.new(2014, 1, 1)
    @ended_on = Date.new(2018, 1, 1)
  end

  test 'should return period as a single string, with both dates provided' do
    assert_equal '2014 - 2018', study_period(@started_on, @ended_on)
    assert_equal 'January 2014 - January 2018', work_period(@started_on, @ended_on)
  end

  test 'should return period from the input date to present, with only started_on provided' do
    @ended_on = nil
    assert_equal '2014 - Present', study_period(@started_on, @ended_on)
    assert_equal 'January 2014 - Present', work_period(@started_on, @ended_on)
  end

  test 'should return an empty string, with only ended_on provided' do
    @started_on = nil
    assert_equal '', study_period(@started_on, @ended_on)
    assert_equal '', work_period(@started_on, @ended_on)
  end

  test 'should return an empty string, with no dates provided' do
    @started_on = nil
    @ended_on = nil
    assert_equal '', study_period(@started_on, @ended_on)
    assert_equal '', work_period(@started_on, @ended_on)
  end
end
