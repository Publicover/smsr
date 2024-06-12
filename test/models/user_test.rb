require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should have columns' do
    assert User.column_names.include?('email')
    assert User.column_names.include?('password_digest')
  end

  test 'shold know sms_texts' do 
    assert users(:one).sms_texts.include?(sms_texts(:one))
    refute users(:one).sms_texts.include?(sms_texts(:three))
  end
end
