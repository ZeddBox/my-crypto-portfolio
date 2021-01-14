class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :purchases

  def total_invested
    total_invested = 0
    self.purchases.all.each do |purchase|
      total_invested += purchase.total
    end
    return total_invested
  end 

  def crypto_amount(crypto)
    crypto_amount = 0.0
    self.purchases.all.each do |purchase|
      if purchase.crypto == crypto
        crypto_amount += purchase.number
      end
    end
    return crypto_amount
  end

  def crypto_total_price(crypto)
    crypto_total_price = 0.0
    self.purchases.all.each do |purchase|
      if purchase.crypto == crypto
        crypto_total_price += Currency.find_by('name': crypto).price * purchase.number
      end
    end
    return crypto_total_price
  end

  def crypto_percentage(crypto)
    total = self.total.round(4)
    crypto_percentage = (crypto_total_price(crypto) / total ) * 100
    return crypto_percentage  
  end

  def total
    total = 0
    self.purchases.all.each do |purchase|
      total += Currency.find_by("name": purchase.crypto).price * purchase.number
    end
    return total
  end 




end
