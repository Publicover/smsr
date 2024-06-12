class AddMultipartTextToSmsTexts < ActiveRecord::Migration[7.0]
  def change
    add_column :sms_texts, :multipart_text, :text, array: true, default: []
  end
end
