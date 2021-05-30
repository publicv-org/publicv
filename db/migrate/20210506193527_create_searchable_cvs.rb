class CreateSearchableCvs < ActiveRecord::Migration[5.2]
  def change
    create_view :searchable_cvs, materialized: true
    add_index :searchable_cvs, :cv_id
    add_index :searchable_cvs, :user_id
  end
end
