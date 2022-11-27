class AddReferenceToCurrentAlquilerToAutosAndUsers < ActiveRecord::Migration[7.0]
  def change
    # add reference to current alquiler in autos table
    add_reference :autos, :current_alquiler, foreign_key: { to_table: :alquilers }, null: true
    # add reference to current alquiler in users table
    add_reference :users, :current_alquiler, foreign_key: { to_table: :alquilers }, null: true
  end
end
