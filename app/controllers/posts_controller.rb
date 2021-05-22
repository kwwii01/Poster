class PostsController < ApplicationController
  POSTS_PER_PAGE = 5
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @page = params.fetch(:page, 0).to_i

    if @page < 0
      redirect_to posts_path(params[page: 0])
    end

    @posts = Post.offset(@page * POSTS_PER_PAGE).limit(POSTS_PER_PAGE)

  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :status)
  end
end