class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def index
    @book = Book.new
    @users = User.page(params[:page]).reverse_order
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:user_update] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
