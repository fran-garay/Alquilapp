class CreateReportes < ActiveRecord::Migration[7.0]
  def change
    create_table :reportes do |t|
      t.integer :id_usuario
      t.integer :id_alquiler
      t.string :descripcion
      t.integer :id_supervisor
      t.string :type

      t.timestamps
    end
  end
end
