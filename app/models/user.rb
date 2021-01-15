class User < ApplicationRecord
has_one :portfolio
has_person_name

after_create :create_portfolio

devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable

private
  def create_portfolio
    Portfolio.create(user_id: User.last.id)
  end

end
