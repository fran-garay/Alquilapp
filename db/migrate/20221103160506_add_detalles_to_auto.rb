class AddDetallesToAuto < ActiveRecord::Migration[7.0]
  def change
    add_column :autos, :anio, :integer
    add_column :autos, :tipo_de_caja, :string
    add_column :autos, :tipo_de_combustible, :string
  end
end
