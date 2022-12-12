class ChengeNameReportes < ActiveRecord::Migration[7.0]
  def change
    rename_column :reportes, :id_usuario, :user_id
    rename_column :reportes, :id_alquiler, :alquiler_id 
    rename_column :reportes, :id_supervisor, :admin_id
  end
end
