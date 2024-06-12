# frozen_string_literal: true

class SmsTextSerializer
  include JSONAPI::Serializer
  attributes :body
  belongs_to :user
end
