class AddDetailsToAutos < ActiveRecord::Migration[7.0]
  def change
    add_column :autos, :modelo, :string
  end
end
