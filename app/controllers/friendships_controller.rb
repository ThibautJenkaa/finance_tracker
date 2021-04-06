class FriendshipsController < ApplicationController
  def create 
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "Vous êtes désormais ami avec #{friend.first_name} #{friend.last_name}"
    else
      flash[:alert] = "Il y a une erreur lors du traitement de la requête"
    end
    redirect_to my_friends_path
  end

  def destroy 
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Relation bien supprimée"
    redirect_to my_friends_path
  end
end
