class AddAttributesToAdminsAndUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :phone, :string
    add_column :admins, :birth_date, :date

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :birth_date, :date
  end
end
