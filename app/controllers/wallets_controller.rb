class WalletsController < ApplicationController

    layout "for_users"

    before_action :authenticate_user!
    before_action :verificar_id_belongs_to_user

    def verificar_id_belongs_to_user
        if current_user.id != params[:user_id].to_i
            redirect_to root_path
        end
    end

    def mostrar_wallet
        @wallet = Wallet.find_by(user_id: params[:user_id])
        @cards = Card.where(user_id: params[:user_id])
    end

    def cargar_saldo
        logger.debug "CARGANDO SALDOOOO"
        @wallet = Wallet.find_by(user_id: params[:user_id])
        @wallet.ultima_carga = wallet_params[:ultima_carga]
        @wallet.saldo = @wallet.saldo + wallet_params[:ultima_carga].to_i
        @wallet.save
        logger.debug "DEBUG: #{wallet_params[:ultima_carga]}"
        logger.debug "DEBUG: #{params[:user_id]}"
        redirect_to "/wallets/#{params[:user_id]}"
    end

    def wallet_params
        params.require(:wallet).permit(:user_id, :ultima_carga)
    end

end
