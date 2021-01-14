class CurrenciesController < ApplicationController

  def index
    @currencies = Currency.all.order('rank ASC')
    @current_user = current_user

    @purchases = current_user.portfolio.purchases
  end

  def show
    @id = params[:id]
    @currency = Currency.friendly.find(@id)

    @purchases = current_user.portfolio.purchases
    @amount_purchased = 0.0
    @purchases.each do |purchase|
      if purchase.crypto == @currency.name 
        @amount_purchased += purchase.number
      end
    end

  end

  def update
    quantity = 200
    @data = Currency.get_all_data(quantity)
    Currency.update_data(quantity)
    redirect_to currencies_path
  end
end
