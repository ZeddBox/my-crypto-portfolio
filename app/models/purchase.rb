class Purchase < ApplicationRecord
  belongs_to :portfolio
  belongs_to :user

  def total 
    self.number * self.price.round(4)
  end

end
