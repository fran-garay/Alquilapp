class AddIsOpenToAutos < ActiveRecord::Migration[7.0]
  def change
    add_column :autos, :is_open, :boolean
  end
end
