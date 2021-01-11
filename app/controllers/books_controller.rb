class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:book_new] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render 'index'
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def index
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:book_update] = "You have updated book successfully"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
