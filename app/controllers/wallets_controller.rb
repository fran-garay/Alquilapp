class WalletsController < ApplicationController
    before_action :authenticate_user!
    before_action :verificar_id_belongs_to_user

    def verificar_id_belongs_to_user
        if current_user.id != params[:user_id].to_i
            redirect_to root_path
        end
    end

    def mostrar_wallet
        @wallet = Wallet.find_by(user_id: params[:user_id])
    end 

    def cargar_saldo
        @wallet = Wallet.find_by(user_id: params[:user_id])
        @wallet.ultima_carga = wallet_params[:ultima_carga]
        @wallet.saldo = @wallet.saldo + wallet_params[:ultima_carga].to_i
        @wallet.save
        redirect_to "/wallets/#{params[:user_id]}"
    end

    def wallet_params
        params.require(:wallet).permit(:user_id, :ultima_carga)
        #params.permit(:user_id, :ultima_carga)
    end

end
