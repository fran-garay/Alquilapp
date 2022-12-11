class AddDurationEnCantHorasToAlquiler < ActiveRecord::Migration[7.0]
  def change
    add_column :alquilers, :duracion_en_cant_horas, :integer
  end
end
