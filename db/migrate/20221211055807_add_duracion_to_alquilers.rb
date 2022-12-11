class AddDuracionToAlquilers < ActiveRecord::Migration[7.0]
  def change
    add_column :alquilers, :duracion, :time
  end
end
