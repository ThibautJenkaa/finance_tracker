class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user:current_user, stock: stock)
    flash[:notice] = "L'action #{stock.name} à bien été ajouté à votre portfolio"
    redirect_to my_portfolio_path
  end
end
