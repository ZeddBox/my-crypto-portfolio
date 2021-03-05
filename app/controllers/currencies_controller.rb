class CurrenciesController < ApplicationController

  def index
    @currencies = Currency.all.order('rank ASC')
    @current_user = current_user

    if current_user
      @purchases = current_user.portfolio.purchases
    end
  end

  def show
    @id = params[:id]
    @currency = Currency.friendly.find(@id)

    # For Graph
    @symbol = @currency.currency_symbol
    @data_for_graph = Currency.data_graph(@symbol)
    
    if @data_for_graph['Time Series (Digital Currency Daily)'] != nil
    @data_today = @data_for_graph['Time Series (Digital Currency Daily)'][DateTime.now.strftime('%Y-%m-%d')]['2a. high (USD)']
    @data_1_day = @data_for_graph['Time Series (Digital Currency Daily)'][1.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)']
    @data_2_day = @data_for_graph['Time Series (Digital Currency Daily)'][2.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)']
    @data_3_day = @data_for_graph['Time Series (Digital Currency Daily)'][3.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)']
    @data_4_day = @data_for_graph['Time Series (Digital Currency Daily)'][4.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)']
    @data_5_day = @data_for_graph['Time Series (Digital Currency Daily)'][5.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)']
    @data_6_day = @data_for_graph['Time Series (Digital Currency Daily)'][6.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)']
    end

    if @data_for_graph['Time Series (Digital Currency Daily)'] != nil
      @data = {
        labels: [6.day.ago.strftime('%Y-%m-%d'),5.day.ago.strftime('%Y-%m-%d'),4.day.ago.strftime('%Y-%m-%d'),3.day.ago.strftime('%Y-%m-%d'),2.day.ago.strftime('%Y-%m-%d'),1.day.ago.strftime('%Y-%m-%d'),DateTime.now.strftime('%Y-%m-%d')],
        datasets: [
          {
              label: "USD Price",
              backgroundColor: "rgba(37, 99, 235, 0.3)",
              pointBorderWidth: "10", 
              pointHoverBorderWidth: "15",
              borderColor: "rgba(50, 105, 235, 1)",
              data: [@data_for_graph['Time Series (Digital Currency Daily)'][6.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'], @data_for_graph['Time Series (Digital Currency Daily)'][5.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'], @data_for_graph['Time Series (Digital Currency Daily)'][4.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'], @data_for_graph['Time Series (Digital Currency Daily)'][3.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'], @data_for_graph['Time Series (Digital Currency Daily)'][2.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'], @data_for_graph['Time Series (Digital Currency Daily)'][1.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'], @data_for_graph['Time Series (Digital Currency Daily)'][DateTime.now.strftime('%Y-%m-%d')]['2a. high (USD)']]
          },
        ]
      }
      @options = { 
        height: "200px",
      }
    end

    # For tables
    @purchases = current_user.portfolio.purchases

    @amount_purchased = 0.0
    @purchases.each do |purchase|
      if purchase.crypto == @currency.name 
        @amount_purchased += purchase.number
      end
    end

    if @data_for_graph['Time Series (Digital Currency Daily)'] != nil
      @price_evolution_24hours = ((@data_for_graph['Time Series (Digital Currency Daily)'][DateTime.now.strftime('%Y-%m-%d')]['2a. high (USD)'].to_f - @data_for_graph['Time Series (Digital Currency Daily)'][1.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'].to_f) / @data_for_graph['Time Series (Digital Currency Daily)'][1.day.ago.strftime('%Y-%m-%d')]['2a. high (USD)'].to_f) * 100
    end

  end

  def update
    quantity = 300
    @data = Currency.get_all_data(quantity)
    Currency.update_data(quantity)
    redirect_back(fallback_location: root_path)
  end
end
