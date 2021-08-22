class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per_page(10)
    @title = I18n.t("users")
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user, menu: [:store])
    @title = "#{I18n.t("user")} : #{@user.name}"
  end
end
