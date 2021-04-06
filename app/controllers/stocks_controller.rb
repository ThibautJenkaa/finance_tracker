class StocksController < ApplicationController 

  def search 
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Ce nom d'action n'est pas valide"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Veuillez saisir un nom d'action"
        format.js { render partial: 'users/result' }
      end
    end
  end

end