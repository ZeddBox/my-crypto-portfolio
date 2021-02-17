class PurchasesController < ApplicationController
  autocomplete :currency, :name, :full => true
  autocomplete :purchases, :crypto, :full => true
  

  def index 
    @purchases = current_user.portfolio.purchases
  end

  def new
    @currencies = Currency.all
    @purchase = Purchase.new
    @crypto = []
    crypto = []
    @currencies.all.each do |currency|
      @crypto << currency.id
      crypto << currency.id
    end

    @purchases = current_user.portfolio.purchases
  end

  def create
    @currencies = Currency.all
    @crypto = []
    crypto = []
    @currencies.all.each do |currency|
      @crypto << currency.id
      crypto << currency.id
    end

      @purchase = Purchase.new(user_id: current_user.id, portfolio_id: current_user.portfolio.id, crypto: Currency.find_by(id: params[:crypto]).name, number: params[:number].to_f, price: params[:price].to_f, purchasedate: params[:purchasedate].to_s + " " +params[:purchase_time].to_s)
      if @purchase.valid? == false 
        flash[:alert] = "Warning! Purchase not valid"
        render :new
      else
        if @purchase.save
          flash[:notice] = "Purchase saved !"
          redirect_to root_path
        else
          render :new
        end
      end
  end

  def edit
    @currencies = Currency.all
    @crypto = []
    crypto = []
    @currencies.all.each do |currency|
      @crypto << currency.id
      crypto << currency.id
    end
      
    @purchase = Purchase.find(params[:id])
    if current_user.id != @purchase.user_id
      redirect_to purchase_path
    end

    @crypto_id = Currency.find_by(name: @purchase.crypto).id
  end

  def update
    @purchase = Purchase.find(params[:id])

    if @purchase.update(crypto: Currency.find_by(id: params[:purchase][:crypto]).name, number: params[:purchase][:number].to_f, price: params[:purchase][:price].to_f, purchasedate: params[:purchase][:purchasedate] + " " + params[:purchase][:purchase_time])
      
      flash[:notice] = "Purchase saved!"
      redirect_to purchases_path
    else
      flash[:alert] = "Purchase notsaved!"
      redirect_to purchases_path

    end

  end

  def destroy
    @purchase = Purchase.find(params[:id])
    if @purchase.destroy
      redirect_to purchases_path 
      flash[:success] = "Deleted !"
    else
      flash[:alert] = "Not deleted, try again!"
      render :new
    end  
  end

  private

  def purchase_params
    params.require(:crypto).permit(:number, :price, :purchasedate)
  end
end
