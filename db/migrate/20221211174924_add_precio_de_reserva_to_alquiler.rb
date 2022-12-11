class AddPrecioDeReservaToAlquiler < ActiveRecord::Migration[7.0]
  def change
    add_column :alquilers, :precio_de_reserva, :float
  end
end
