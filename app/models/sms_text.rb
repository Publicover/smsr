# frozen_string_literal: true

class SmsText < ApplicationRecord
  # total number of characters per SMS
  INDIDVIDUAL_CHARACTER_LIMIT = 160
  # we need to append '- part n' to each SMS to be split so we subtract that from the total
  MULTIPART_CHARACTER_LIMIT = 152
  # we need to append '- part n' but we might want to change that sometime
  MULTIPART_MESSAGE = '- part '

  before_create { |record| record[:multipart_text] = enforce_character_limit}

  belongs_to :user

  def character_count
    body.chars.count
  end

  # if an sms is less than 160 characters, we must break it up
  def send_individually?
    character_count <= INDIDVIDUAL_CHARACTER_LIMIT
  end

  # rubocop:disable Metrics/AbcSize
  # returns the body of new sms text objects in an array
  def enforce_character_limit
    individual_sms_texts = []
    # to account for zero indexing
    individual_sms_texts.size
    starting_index = 0
    ending_index = MULTIPART_CHARACTER_LIMIT - 1
    # iterate, storing whole sms in array after adding part number
    loop do
      # get out if we have captured all parts of the message
      break if starting_index + 1 > character_count

      # generate the "- part n" text to add
      multipart_message = MULTIPART_MESSAGE + (individual_sms_texts.size + 1).to_s
      # don't break on whole words
      extra_characters = body[starting_index..ending_index].rpartition(' ').last
      # figure out where to split the string given the above
      splitting_index = (MULTIPART_CHARACTER_LIMIT + starting_index) - extra_characters.chars.count
      # set the new ending_index for the next loop
      ending_index -= (ending_index - splitting_index)
      # capture the divided sms
      individual_sms_texts << (body[starting_index..ending_index] << multipart_message)
      # start the next loop where we left off
      starting_index = ending_index + 1
      # end the next loop where we left off too
      ending_index += MULTIPART_CHARACTER_LIMIT
    end
    individual_sms_texts
  end
  # rubocop:enable Metrics/AbcSize

  # if the sms text is too long, save it as multiple texts in the same record 
  # check for this in the controller before it hits the views
  def check_mulitpart_text
    return if send_individually?

    multipart_text = enforce_character_limit
  end
end
