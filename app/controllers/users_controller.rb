class UsersController < ApplicationController
  before_action :require_authentication, only: [ :show, :update ]

  def new
    @user = User.new
  end

  def create
    begin
      @user = User.new(user_params)
      if User.exists?(email_address: @user.email_address)
        flash.now[:alert] = "Email address already in use."
        render :new, status: :unprocessable_entity
        return
      end

      if @user.password != @user.password_confirmation
        flash.now[:alert] = "Password and confirmation do not match."
        render :new, status: :unprocessable_entity
        return
      end

      if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully."
      else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new
      end
    rescue => e
      flash.now[:alert] = "An unexpected error occurred: #{e.message}"
      render :new, status: :internal_server_error
    end
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :img_url)
  end
end
