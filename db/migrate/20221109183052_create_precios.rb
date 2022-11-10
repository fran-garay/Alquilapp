class CreatePrecios < ActiveRecord::Migration[7.0]
  def change
    create_table :precios do |t|
      t.float :valor
      t.datetime :fecha_de_actualizacion

      t.timestamps
    end
  end
end
