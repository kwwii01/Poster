class PostsController < ApplicationController
  POSTS_PER_PAGE = 5
  before_action :authenticate_user!, only: %i[ new create edit update destroy]
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    authorize Post

    @page = params.fetch(:page, 0).to_i
    @category = params.fetch(:category, "All")

    if @category == "All"
      if @page < 0
        redirect_to posts_path(page: 0)
      end
      @posts = Post.offset(@page * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
    else
      if @page < 0
        redirect_to posts_path(page: 0, category: @category)
      end
        @posts = Post.where(category: @category).offset(@page * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)
    end
  end

  def show
    authorize @post

    @post = Post.find(params[:id])
  end

  def new
    authorize Post

    @post = Post.new
  end

  def create
    authorize Post

    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    authorize @post

    @post = Post.find(params[:id])
  end

  def update
    authorize @post

    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    authorize @post

    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :category, :picture)
  end
end