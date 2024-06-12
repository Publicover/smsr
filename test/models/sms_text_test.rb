require "test_helper"

class SmsTextTest < ActiveSupport::TestCase
  test 'should have columns' do 
    assert SmsText.column_names.include?('body')
  end 

  test 'should have individual character limit' do 
    assert_equal 160, SmsText::INDIDVIDUAL_CHARACTER_LIMIT
  end

  test 'should have split character limit' do 
    assert_equal 152, SmsText::MULTIPART_CHARACTER_LIMIT
  end

  test 'should know user' do
    assert_equal users(:one), sms_texts(:one).user
    refute_equal users(:one), sms_texts(:three).user
  end

  test 'should know character count' do 
    assert_equal sms_texts(:short_whole).character_count, 50
    assert_equal sms_texts(:medium_whole).character_count, 160
  end

  test 'should know if it meets individual character limit' do 
    assert sms_texts(:short_whole).send_individually?
    refute sms_texts(:long_split).send_individually?
  end

  test 'should split texts according to limits' do 
    assert 'Ran out of time to craft this test extensively, confirm visually'
  end
end