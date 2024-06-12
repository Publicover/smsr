# frozen_string_literal: true

class SmsText < ApplicationRecord
  # total number of characters per SMS
  INDIDVIDUAL_CHARACTER_LIMIT = 160
  # we need to append '- part n' to each SMS to be split so we subtract that from the total
  SPLIT_CHARACTER_LIMIT = 152

  belongs_to :user
end
