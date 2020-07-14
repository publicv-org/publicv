class ChangeDescriptionColumnTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :educations, :description, :text
    change_column :experiences, :description, :text
  end
end
