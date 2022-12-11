class AddTiempoDeDemoraToAlquiler < ActiveRecord::Migration[7.0]
  def change
    add_column :alquilers, :tiempo_de_demora, :time
    add_column :alquilers, :precio_por_demora, :float
  end
end
