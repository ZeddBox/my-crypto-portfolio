class HomeController < ApplicationController
  
  def index

    if current_user
    @purchases = current_user.portfolio.purchases
    end

  end
end