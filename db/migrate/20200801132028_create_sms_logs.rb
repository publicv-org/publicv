class CreateSmsLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :sms_logs do |t|
      t.string :sms_sid
      t.string :account_sid
      t.string :sms_status
      t.string :from
      t.string :to
      t.string :body
      t.string :api_version
      t.string :forwarded_from
      t.string :direction
      t.string :from_city
      t.string :from_state
      t.string :from_zip
      t.string :from_country
      t.string :to_city
      t.string :to_state
      t.string :to_zip
      t.string :to_country
      t.belongs_to :user
      t.timestamps
    end
  end
end
