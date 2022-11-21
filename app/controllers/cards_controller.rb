class CardsController < ApplicationController

    require 'credit_card_validations/string'

    def index
        @cards = Card.all
    end

    def show
        @card = Card.find(params[:number])
    end

    def create

        logger.debug "\n\n\nEntra al create\n\n\n"

        @card = Card.new
        @card.name = card_params[:name]
        if card_params[:number].to_s.credit_card_brand_name == false
            @card.number = card_params[:number]
        else
            flash[:alert] = "El número de tarjeta es inválido"
            redirect_to "/wallets/#{params[:user_id]}"
            return
        end
        @card.cvv = card_params[:cvv]
        @card.date = card_params[:date].to_s
        @card.user_id = params[:user_id]
        @card.brand = card_params[:number].to_s.credit_card_brand_name

        logger.debug "\n\n\nAsigna\n\n\n"

        if @card.save

            logger.debug "\n\n\nGuardado\n\n\n"

            redirect_to "/wallets/#{params[:user_id]}"
        else

            logger.debug "\n\n\nNo guardado\n\n\n"

            redirect_to "/wallets/#{params[:user_id]}"
        end
    end

    def card_params
        params.require(:card).permit(:name, :number, :cvv, :date)
    end
end