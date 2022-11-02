class WalletsController < ApplicationController

    def show
        @saldo  = Wallet.all
    end

    def cargar_saldo
        w = Wallet.find_by(user_id: :user_id)
        w.saldo = :monto + w.saldo
    end

end
