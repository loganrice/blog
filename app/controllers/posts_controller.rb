class PostsController < ApplicationController
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy]

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by(slug: params[:id])
  end
  
  def show
    @post = Post.find_by(slug: params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.save
  end

  def update
    @post = Post.find_by(slug: params[:id])
    if @post.update(post_params)
      redirect_to root_path
    else
      flash[:notice] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :subtitle, :text, :tag_list)
  end
end
