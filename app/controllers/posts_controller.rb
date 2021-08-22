class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user, menu: :store).page(params[:page]).per_page(10)
    @title = I18n.t("posts")
  end

  def new
    @post = Post.new
    @post.user = User.new # TODO 로그인 처리
    @post.menu = Menu.new
    @post.menu.store = Store.new
    @title = I18n.t("new_post")
  end

  def create
    @post = Post.new(post_params)
    @user = User.find_or_initialize_by(name: user_params[:name]) # TODO 로그인 처리
    @store = Store.find_or_initialize_by(name: store_params[:name])
    @menu = Menu.find_or_initialize_by(name: post_params[:name])
    @user.attributes = user_params
    @store.attributes = store_params
    @menu.attributes = menu_params
    @menu.store = @store
    @post.user = @user
    @post.menu = @menu
    @post.save!
    redirect_to post_path(@post)
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
    render "new"
  end

  def show
    @title = I18n.t("post")
  end

  def edit
    @title = I18n.t("edit_post")
  end

  def update
    @post.attributes = post_params
    @post.save!
    redirect_to post_path(@post)
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
    render "edit"
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, flash: { notice: I18n.t("destroy_completed") }
  rescue ActiveRecord::RecordNotDestroyed => e
    redirect_back fallback_location: post_path(@post), flash: { alert: e.message }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:context, :may_retry, menu_attributes: [:id, :price])
  end

  def user_params
    params.require(:post).require(:user_attributes).permit(:id, :name)
  end

  def menu_params
    params.require(:post).require(:menu_attributes).permit(:id, :name, :price)
  end

  def store_params
    params.require(:post).require(:menu_attributes).require(:store_attributes).permit(:id, :name)
  end

  def validate_user
    # TODO 로그인 처리 후 삭제
    unless @post.user.name == user_params[:name]
      redirect_back fallback_location: :root_path, flash: { alert: I18n.t("invalid_user", user_name: user_params[:name]) }
    end
  end
end
