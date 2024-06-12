require "test_helper"

class SmsTextTest < ActiveSupport::TestCase
  test 'should have columns' do 
    assert SmsText.column_names.include?('body')
  end 

  test 'should have individual character limit' do 
    assert_equal 160, SmsText::INDIDVIDUAL_CHARACTER_LIMIT
  end

  test 'should have split character limit' do 
    assert_equal 152, SmsText::SPLIT_CHARACTER_LIMIT
  end

  test 'should know user' do
    assert_equal users(:one), sms_texts(:one).user
    refute_equal users(:one), sms_texts(:three).user
  end
end