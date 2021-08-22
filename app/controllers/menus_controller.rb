class MenusController < ApplicationController
  def index
    @q = Menu.ransack(params[:q])
    @menus = @q.result.page(params[:page]).per_page(5)
    @title = I18n.t("menus")
  end

  def show
    @menu = Menu.find(params[:id])
    @posts = @menu.posts.includes(:user, menu: [:store])
    @users = @menu.users
    @title = "#{I18n.t("menu")} : #{@menu.name}"
  end
end
