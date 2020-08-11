require 'test_helper'

class LanguagesHelperTest < ActionView::TestCase
  test 'cefr_level should return the corresponding translated CEFR level' do
    assert_equal 'A1 - Beginner', cefr_level('a1')
  end

  test 'cefr_level_options should return a hash with the options' do
    cefr_options = {
      a1: 'A1 - Beginner',
      a2: 'A2 - Elementary',
      b1: 'B1 - Intermediate',
      b2: 'B2 - Upper intermediate',
      c1: 'C1 - Advanced',
      c2: 'C2 - Proficiency'
    }

    assert_equal cefr_options, cefr_level_options
  end
end
