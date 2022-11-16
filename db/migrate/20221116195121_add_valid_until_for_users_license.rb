class AddValidUntilForUsersLicense < ActiveRecord::Migration[7.0]
  def change

    add_column :users, :license_valid_until, :date
  end
end
