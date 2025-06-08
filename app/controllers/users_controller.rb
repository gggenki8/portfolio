class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @is_current_user = (@user == current_user)
  end

  def edit_profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: "プロフィールを更新しました！"
    else
      render :edit_profile
    end
  end

  private

  # user_params を一つにまとめ、:skill も許可する
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :image,
      :profile,
      :skill
    )
  end
end
