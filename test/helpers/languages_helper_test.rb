require 'test_helper'

class LanguagesHelperTest < ActionView::TestCase
  test 'cefr_level should return the corresponding translated CEFR level' do
    assert_equal t('cefr_levels.a1'), cefr_level('a1')
  end

  test 'cefr_level_options should return a hash with the options' do
    cefr_options = {
      a1: t('cefr_levels.a1'),
      a2: t('cefr_levels.a2'),
      b1: t('cefr_levels.b1'),
      b2: t('cefr_levels.b2'),
      c1: t('cefr_levels.c1'),
      c2: t('cefr_levels.c2')
    }

    assert_equal cefr_options, cefr_level_options
  end
end
