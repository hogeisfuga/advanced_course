class RelationshipsController < ApplicationController

  # followする
  def create
    binding.pry
    user = User.find(relationship_params[:user_id])
    current_user.follow(user)
    redirect_to user
  end

  # followを外す
  def destroy
    binding.pry
    user = User.find(relationship_params[:user_id])
    current_user.unfollow(user)
    redirect_to user
  end

  private

  def relationship_params
    params.require(:relationship).permit(:user_id)
  end

end
