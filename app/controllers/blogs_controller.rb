class BlogsController < ApplicationController
  before_action :require_authentication, only: [:new, :create]
  before_action :set_user, only: [ :index, :show ]

  def index
    @blogs = Blog.all.order(created_at: :desc)
  end

  def show
    @blog = @user.blogs.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to @blog, notice: "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_user
    if params[:id].present?
      @blog = Blog.find(params[:id])
      @user = @blog.user
    elsif params[:user_id].present?
      @user = User.find(params[:user_id])
    else
      # Handle the case where neither is provided, optional
      render plain: "User not found", status: :not_found
    end
  end
  
end
