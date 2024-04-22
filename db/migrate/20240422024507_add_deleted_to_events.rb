class AddDeletedToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :deleted, :boolean
  end
end
