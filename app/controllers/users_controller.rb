class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:name_friend].present?
      @friend = User.where(last_name: params[:name_friend]).first
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/result_search_friend' }
        end
      else
        flash[:alert] = "Aucun utilisateur n'a été trouvé avec ce nom"
        respond_to do |format|
          format.js { render partial: 'users/result_search_friend' }
        end
      end
    else
      flash[:alert] = "Veuillez saisir un nom"
      respond_to do |format|
        format.js { render partial: 'users/result_search_friend' }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end
  
end
