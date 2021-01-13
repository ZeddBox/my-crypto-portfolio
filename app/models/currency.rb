class Currency < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def self.call(url)
    headers = {
      'X-CMC_PRO_API_KEY' => ENV['COINMARKETCAP_KEY']
    }
    response = HTTParty.get(url,:headers => headers).parsed_response
  end

  def self.get_all_data(quantity)
    call = self.call("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=#{quantity}&convert=USD")
    data = call["data"]
    return data
  end

  def self.check_if_exists_in_db(hash)
    exists = false
    Currency.all.each do |db_crypto|
      if db_crypto.id_CMC == hash["id"]
        exists = true
      end
    end
    return exists
  end

  def self.update_data(quantity)
    data = Currency.get_all_data(quantity)
    data.sort_by! { |k| k["rank"] }
    data.each do |crypto|
      exist = Currency.check_if_exists_in_db(crypto)
      if exist == true
        Currency.where(id_CMC: crypto["id"]).update(
          price: crypto["quote"]["USD"]["price"].round(4),
          slug: crypto["slug"],
          rank: crypto["cmc_rank"],
          currency_symbol: crypto["symbol"].upcase
        )
      else
        Currency.create!([
          {
            name: crypto["name"],
            currency_symbol: crypto["symbol"].upcase,
            slug: crypto["slug"],
            price: crypto["quote"]["USD"]["price"].round(4),
            market_cap: crypto["quote"]["USD"]["market_cap"],
            max_supply: crypto["max_supply"],
            rank: crypto["cmc_rank"],
            logo: "https://s2.coinmarketcap.com/static/img/coins/64x64/#{crypto["id"]}.png",
            id_CMC: crypto["id"],
            portfolio_value: 0,
            portfolio_qty: 0
          }
        ])
      end
    end
  end
end