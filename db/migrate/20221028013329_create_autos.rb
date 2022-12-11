class CreateAutos < ActiveRecord::Migration[7.0]
  def change
    create_table :autos do |t|
      t.string :patente
      t.float :porcentaje_combustible
      t.string :estado
      t.timestamps
    end
  end
end
