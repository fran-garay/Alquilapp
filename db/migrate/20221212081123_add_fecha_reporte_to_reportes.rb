class AddFechaReporteToReportes < ActiveRecord::Migration[7.0]
  def change
    add_column :reportes, :fecha_reporte, :date
  end
end
