class AddAutoAndUserColumns < ActiveRecord::Migration[7.0]
  def change
    # add reference to user in users table
    add_reference :alquilers, :user, foreign_key: true
    # add reference to auto in autos table
    add_reference :alquilers, :auto, foreign_key: true
    # add column with date of alquiler
    add_column :alquilers, :fecha_alquiler, :date
    # add column with time of alquiler
    add_column :alquilers, :hora_alquiler, :time
    # add column with date of devolucion
    add_column :alquilers, :fecha_devolucion, :date
    # add column with time of devolucion
    add_column :alquilers, :hora_devolucion, :time
    # add column with total price of alquiler
    add_column :alquilers, :precio_total, :decimal
  end
end
