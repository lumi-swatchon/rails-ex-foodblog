class StoresController < ApplicationController
  def index
    @q = Store.ransack(params[:q])
    @stores = @q.result.page(params[:page]).per_page(10)
    @title = I18n.t("stores")
  end

  def show
    @store = Store.find(params[:id])
    @menus = @store.menus
    @posts = Post.joins(:menu).where(menus: {store_id: @store.id}).includes(:user, menu: [:store])
    @users = @posts.map(&:user).uniq
    @title = "#{I18n.t("store")} : #{@store.name}"
  end
end
