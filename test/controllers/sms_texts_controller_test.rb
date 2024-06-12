require "test_helper"

class SmsTextsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    login_as_user
  end

  test 'should get index' do
    get sms_texts_path, headers: @user_headers
    assert_response :success
    assert_equal users(:one).sms_texts.count, json['data'].size
  end

  test 'should get show' do
    get sms_text_path(sms_texts(:one)), headers: @user_headers
    assert_response :success
    assert_equal sms_texts(:one).id, json['data']['id'].to_i
  end

  test 'should create' do
    assert_difference('SmsText.count') do
      post sms_texts_path, params: {
        sms_text: {
          user_id: users(:one).id, 
          body: Faker::Lorem.sentence(word_count: 25)
        }
      }.to_json, headers: @user_headers
    end
    assert_response :created
  end

  test 'should create if long text' do 
    post sms_texts_path, params: {
      sms_text: {
        user_id: users(:one).id, 
        body: Faker::Lorem.sentence(word_count: 100)
      }
    }.to_json, headers: @user_headers
    text = SmsText.last
    refute text.multipart_text.nil?
  end

  test 'should update' do 
    new_body = 'So short!'
    patch sms_text_path(sms_texts(:one)), 
      params: {
        user_id: users(:one).id, 
        body: new_body 
      }.to_json, 
      headers: @user_headers
    assert_response :success
    assert_equal new_body, sms_texts(:one).reload.body
  end

  test 'should destroy' do 
    assert_difference('SmsText.count', -1) do 
      delete sms_text_path(sms_texts(:one)), headers: @user_headers
    end
    assert_response :success
  end
end