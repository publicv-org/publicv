class CreateCallLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :call_logs do |t|
      t.string :call_sid
      t.string :account_sid
      t.string :call_status
      t.string :from
      t.string :to
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
      t.string :call_duration
      t.string :call_type
      t.belongs_to :user
      t.timestamps
    end
  end
end
