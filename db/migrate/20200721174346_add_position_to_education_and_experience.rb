class AddPositionToEducationAndExperience < ActiveRecord::Migration[5.2]
  def change
    add_column :educations, :position, :integer, default: 0
    add_column :experiences, :position, :integer, default: 0
    add_column :cvs, :custom_experience_sort, :boolean, default: false
    add_column :cvs, :custom_education_sort, :boolean, default: false
  end
end
