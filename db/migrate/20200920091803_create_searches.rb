class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :query
      t.string :slug
      t.string :locale, null: false, default: 'en'
      t.integer :views, null: false, default: 0

      t.timestamps
    end
    add_index :searches, :query, unique: true
    add_index :searches, :slug, unique: true
    add_index :searches, [:query, :locale]
  end
end
