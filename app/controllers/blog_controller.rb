class BlogController < ApplicationController
  before_action :require_authentication, only: [ :new, :create ]

  def index
    @blogs = Blog.all.order(created_at: :desc)
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    puts "\n\n\n"
    puts "Creating blog: #{params.inspect}"
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to @blog, notice: "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
