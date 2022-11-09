class AddIsBeingValidatedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_being_validated, :boolean, default: true
  end
end
