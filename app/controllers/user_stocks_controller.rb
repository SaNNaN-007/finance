class UserStocksController < ApplicationController

    def create 

        stock = Stock.check_db(params[:ticker])

        if stock.blank?

            stock = Stock.new_lookup(params[:ticker])
            # stock.save
        
            @user_stock = UserStock.create(user: current_user, stock: stock)

            flash[:notice] = "The Stock #{stock.name} successfully added to your Portfolio."
            redirect_to my_portfolio_path
            
        end

    end

    def destroy
        stock = Stock.find(params[:id])
        user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
        user_stock.destroy
        stock.destroy
        flash[:notice] = "Stock #{stock.ticker} Successfully Removed."
        redirect_to my_portfolio_path
    end
end
