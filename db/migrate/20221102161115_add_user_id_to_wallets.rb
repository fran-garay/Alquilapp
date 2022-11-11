class AddUserIdToWallets < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :user_id, :bigint
  end
end
