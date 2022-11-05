class WalletsController < ApplicationController

    def mostrar_wallet
        @wallet = Wallet.find_by(user_id: params[:user_id])
    end 

    def cargar_saldo
        @wallet = Wallet.find_by(user_id: params[:user_id])
        p = wallet_params
        logger.debug "Saldo: #{p[:ultima_carga]}"
        @wallet.saldo = @wallet.saldo + p[:ultima_carga]
        @wallet.save
        redirect_to "/wallets/#{params[:user_id]}"
    end

    def wallet_params
        params.permit(:user_id, :ultima_carga)
    end

end
