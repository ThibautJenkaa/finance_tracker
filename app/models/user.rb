class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_track?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end 

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_track?(ticker_symbol)
  end

  def full_name 
    if first_name || last_name
      return "#{first_name} #{last_name}" 
    else
      return "Anonymous"
    end
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friend_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end
end
