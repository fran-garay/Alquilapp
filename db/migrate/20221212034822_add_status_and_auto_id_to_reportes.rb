class AddStatusAndAutoIdToReportes < ActiveRecord::Migration[7.0]
  def change
    add_column :reportes, :auto_id, :integer
    add_column :reportes, :status, :integer, default: 0
    add_index :reportes, :status
  end
end
