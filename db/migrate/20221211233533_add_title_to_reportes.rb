class AddTitleToReportes < ActiveRecord::Migration[7.0]
  def change
    add_column :reportes, :title, :string
  end
end
