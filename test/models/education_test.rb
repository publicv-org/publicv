require 'test_helper'

class EducationTest < ActiveSupport::TestCase
  setup do
    @education = educations(:education)
  end

  test 'school should be present' do
    @education.school = ''
    assert_not @education.valid?
  end

  test 'description length should not exceed the maximum length provided' do
    @education.description = Faker::Lorem.paragraph(1001..1002)
    assert_not @education.valid?
  end
end
