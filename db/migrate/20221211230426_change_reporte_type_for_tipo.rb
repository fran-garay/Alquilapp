class ChangeReporteTypeForTipo < ActiveRecord::Migration[7.0]
  def change
    #make reportes.type an enum instead of a string
    remove_column :reportes, :type
    add_column :reportes, :tipo, :integer, default: 0
    add_index :reportes, :tipo
  end
end
