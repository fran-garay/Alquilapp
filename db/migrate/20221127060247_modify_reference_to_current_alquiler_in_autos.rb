class ModifyReferenceToCurrentAlquilerInAutos < ActiveRecord::Migration[7.0]
  def change
    # remove reference to current alquiler in autos table
    remove_reference :autos, :current_alquiler, foreign_key: { to_table: :alquilers }, null: true
    # add reference to  alquiler in autos table
    add_reference :autos, :alquiler, foreign_key: true, null: true
    # remove reference to current alquiler in users table
    remove_reference :users, :current_alquiler, foreign_key: { to_table: :alquilers }, null: true
    # add reference to  alquiler in users table
    add_reference :users, :alquiler, foreign_key: true, null: true
  end
end
