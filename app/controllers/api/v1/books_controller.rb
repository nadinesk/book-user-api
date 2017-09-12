class Api::V1::BooksController < ApplicationController

   def index   	
      @books = User.find_by(id: params[:user_id])&.books
      render 'books/books.json.jbuilder', books: @books
      #render json: Book.all.to_json()     
   end


   def show
      @book = Book.find_by(id: params[:id]) 

      if @book 
        render 'books/book.json.jbuilder', book: @book
      else 
        render json: {
          errors: {
            message: "Page not found"
          }
        }, status: 404
      end
      # render json: Book.find_by(id: params[:id]).to_json()

   end

   def create

      @user = User.find_by(id: params[:user_id])
      if @user.id == current_user.id
        
            @book = @user.decisions.new(book_params)

        if @book.save
          render 'books/book.json.jbuilder', book: @book
        else 
          render json: {
            errors: @book.errors.full_messages
          }, status: 500
        end
      else 
        render json: {
          errors: [
            {message: "No permission to add decisions"}
          ]
        }, status: 403
      end
   			# @book = Book.new(book_params)
   			# if @book.save
   			# 	render '/books/book.json.jbuilder', book: @book
   			# else
   			# 	render json: {
   			# 		errors: @book.errors.full_messages
   			# 	}, status: 500
   			# end
   		
   end

   def update
      @user = User.find_by(id: params[:user_id])
      if @user.id == current_user.id
        @book = @user.books.find_by(id: params[:id])
        if @book.update_attributes(book_params) 
          render 'books/book.json.jbuilder', book: @book
        else 
          render json: {
            errors: @book.errors.full_messages
          }, status: 500
        end
      else 
        render json: {
          errors: [
            {message: "You don't have permission to edit"}
          ]
        }, status: 403
      end

   			# @book = Book.find_by(id: params[:id])
   			# if @book.update_attributes(book_params)
   			# 	render 'books/book.json.jbuilder', book: @book
   			# else
   			# 	render json: {
   			# 		errors: @book.errors.full_messages
   			# 	}, status: 500
   			# end
   		
   end

   def destroy

      book = Book.find_by(id: params[:id])
      if book
        book.destroy
        head :no_contnet
      else
        render json: {
          errors: {
            message: "Page not found"
          }
        }, status: 404
      end
   	

   end

    def ping
       render json: {
         status: "OK"
       }
   end

  private

    def book_params
      params.require(:book).permit(:title, :author, :rating, :notes)
    end


end
