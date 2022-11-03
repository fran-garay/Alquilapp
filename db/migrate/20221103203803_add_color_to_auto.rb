class AddColorToAuto < ActiveRecord::Migration[7.0]
  def change
    add_column :autos, :color, :string
  end
end
