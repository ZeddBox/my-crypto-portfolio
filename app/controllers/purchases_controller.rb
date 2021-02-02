class PurchasesController < ApplicationController
  autocomplete :currency, :crypto, :full => true

  def index 
    @purchases = current_user.portfolio.purchases
  end

  def new
    @currencies = Currency.all
    @purchase = Purchase.new
    @crypto = []
    crypto = []
    @currencies.all.each do |currency|
      @crypto << currency.name
      crypto << currency.name
    end

    @purchases = current_user.portfolio.purchases
  end

  def create
    @currencies = Currency.all
    @crypto = []
    crypto = []
    @currencies.all.each do |currency|
      @crypto << currency.name
      crypto << currency.name
    end

    if @crypto.include? params[:crypto]
      @purchase = Purchase.new(user_id: current_user.id, portfolio_id: current_user.portfolio.id, crypto: params[:crypto], number: params[:number].to_f, price: params[:price].to_f, purchasedate: params[:purchasedate].to_s + " " +params[:purchase_time].to_s)
      if @purchase.valid? == false 
        flash.now[:alert] = "Warning! Purchase not valid"
        render :new
      else
        if @purchase.save
          flash[:success] = "Purchase saved !"
          redirect_to root_path
        else
          render :new
        end
      end
    else
      flash.now[:alert] = "Warning! Purchase not valid"
      render :new
    end
  end

  private

  def purchase_params
    params.require(:crypto).permit(:number, :price, :purchasedate)
  end
end
