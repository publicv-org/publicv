class CreateNewsletters < ActiveRecord::Migration[5.2]
  def change
    create_table :newsletters do |t|
      t.string :name
      t.string :subject
      t.text :content
      t.string :recipient_ids
      t.datetime :sent_at
      t.string :slug
      t.string :preference_type

      t.timestamps
    end
  end
end
