class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.integer :newsletter_id

      t.timestamps
    end
  end
end
