class AddIfHandlingReport < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :is_handling_report, :boolean, default: false
  end
end
