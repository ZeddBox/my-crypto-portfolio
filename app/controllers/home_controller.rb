class HomeController < ApplicationController
  def index

    @purchases = current_user.portfolio.purchases

  end
end