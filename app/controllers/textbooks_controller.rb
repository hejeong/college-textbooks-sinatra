class TextbooksController < ApplicationController
  use Rack::Flash

  # textbooks index page
  # shows list of textbooks for sale
  # shows only the textbooks that haven't been purchased yet
  get '/textbooks' do
    # can't be seen unless logged in
    logged_in?
    @textbooks = Textbook.all.select do |book|
      book.buyer_id == nil
    end
    @user = current_user
    erb :'textbooks/textbooks'
  end

  # renders a new form to create a new textbook listing
  get '/textbooks/new' do
    # can't be seen unless logged in
    logged_in?
    erb :'textbooks/new'
  end

  # new form sends input values to this post route
  post '/textbooks' do
    # has validations (no input fields can be blank except image URL)
    if params[:title] == "" || params[:author] == "" || params[:price] == ""
      flash[:message] = "Input fields can't be blank."
      redirect to '/textbooks/new'
    end
    @textbook = Textbook.new(title: params[:title], author: params[:author], price: params[:price])
    if params[:image_url] != ""
      @textbook.image_url = params[:image_url]
    end
    @textbook.user_id = session[:user_id]
    @textbook.save
    flash[:message] = "Listing now posted."
    redirect to "/textbooks/#{@textbook.id}"
  end

  # listing show page
  get '/textbooks/:id' do
    # can't be see until logged in
    logged_in?
    @textbook = Textbook.find_by_id(params[:id])
    # can't see edit/delete button unless owner
    if @textbook.user_id == session[:user_id]
      @owner = true
    else
      @owner = false
    end
    erb :'/textbooks/show'
  end

  # edit form
  get '/textbooks/:id/edit' do
    # must be logged in to view edit page
    logged_in?
    @textbook = Textbook.find_by_id(params[:id])
    # can't be edited by other users; will be redirected
    if current_user.id != @textbook.user_id
      flash[:message] = "You cannot edit another user's item."
      redirect to '/textbooks'
    end
    erb :'/textbooks/edit'
  end

  # edit form sends data to this patch request
  patch '/textbooks/:id' do
    # has validations, no empty fields allowed
    if params[:title] == "" || params[:author] == "" || params[:price] == ""
      flash[:message] = "Input fields can't be blank."
      redirect to "/textbooks/#{params[:id]}/edit"
    end
    @textbook = Textbook.find_by_id(params[:id])
    @textbook.update(title: params[:title], author: params[:author], price: params[:price])
    if params[:image_url] != ""
      @textbook.image_url = params[:image_url]
      @textbook.save
    end
    flash[:message] = "Update successful."
    redirect to "textbooks/#{@textbook.id}"
  end

  # purchase button sends data to this patch request
  patch '/textbooks/:id/purchase' do
    @textbook = Textbook.find_by_id(params[:id])
    @textbook.update(buyer_id: session[:user_id])
    flash[:message] = "Purchase successful."
    redirect to "/textbooks/#{@textbook.id}"
  end

  # can't delete unless owner
  # button can't be accessed on show page
  delete '/textbooks/:id/delete' do
    @textbook = Textbook.find_by_id(params[:id])
    @textbook.destroy
    flash[:message] = "Listing successfully deleted."
    redirect to '/textbooks'
  end
end
