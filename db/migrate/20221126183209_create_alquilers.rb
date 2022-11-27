class CreateAlquilers < ActiveRecord::Migration[7.0]
  def change
    create_table :alquilers do |t|

      t.timestamps
    end
  end
end
