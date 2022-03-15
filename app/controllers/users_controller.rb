class UsersController < ApplicationController

  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @user_friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])

    @tracked_stocks = @user.stocks

  end

  def search

    if params[:friend].present?

      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      
      if @friends
        respond_to do |format|
          format.js {render partial: 'users/friend' }
        end
        
      else
        respond_to do |format|
          flash.now[:alert] = "User doesn't exits."
          format.js {render partial: 'users/friend' }
        end
        
      end

    else
      
     respond_to do |format|
          flash.now[:alert] = "Please Enter"
          format.js {render partial: 'users/friend' }
        end
      
    end
  end

end
