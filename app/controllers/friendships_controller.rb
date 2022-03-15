class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend])

    current_user.friendships.build(friend_id: friend.id)
    
    if current_user.save
      flash[:notice] = "Following Friend"
    else
      flash[:alert] = "There is something wrong."
    end

    redirect_to my_friends_path

  end


  def destroy
    friendships = current_user.friendships.where(friend_id: params[:id]).first
    friendships.destroy
    flash[:notice] = "Stopped Following"
    redirect_to my_friends_path
  end

end
