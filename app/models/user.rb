class User < ApplicationRecord

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def stock_limit
    stocks.count < 10
  end

  def stock_already_exist(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def can_track_stocks(ticker_symbol)
    stock_limit && !stock_already_exist(ticker_symbol)
  end

end
