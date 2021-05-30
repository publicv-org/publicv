class RemoveIndexSearchesOnQueryInCvs < ActiveRecord::Migration[5.2]
  def change
    remove_index :searches, :query
  end
end
