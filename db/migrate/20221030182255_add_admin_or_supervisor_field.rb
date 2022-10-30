class AddAdminOrSupervisorField < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :is_admin, :boolean, default: false
  end
end
