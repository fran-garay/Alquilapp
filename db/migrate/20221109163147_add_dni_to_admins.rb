class AddDniToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :dni, :integer
  end
end
