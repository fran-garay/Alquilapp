class AddHoraUserDevoulcionToAlquilers < ActiveRecord::Migration[7.0]
  def change
    add_column :alquilers, :fecha_user_devolucion, :date
    add_column :alquilers, :hora_user_devolucion, :time
  end
end
