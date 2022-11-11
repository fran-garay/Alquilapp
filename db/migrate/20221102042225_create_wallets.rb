class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :saldo
      t.float :ultimo_gasto
      t.float :ultima_carga

      t.timestamps
    end
  end
end
