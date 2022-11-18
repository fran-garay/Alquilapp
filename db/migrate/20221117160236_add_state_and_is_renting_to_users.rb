class AddStateAndIsRentingToUsers < ActiveRecord::Migration[7.0]
  def change
    # add column to users that is a state which is an enum with the values "Validado", "Pendiente", "Rechazado" and "Bloqueado"
    add_column :users, :status, :integer, default: 1
    add_column :users, :is_renting, :boolean
    # remove is_being_validated column
    remove_column :users, :is_being_validated
  end
end
