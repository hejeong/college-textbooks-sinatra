class TextbooksController < ApplicationController
  use Rack::Flash

  get '/textbooks' do
    logged_in?
    erb :'textbooks/textbooks'
  end

  get '/textbooks/new' do
    logged_in?
    erb :'textbooks/new'
  end

  post '/textbooks' do
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

  get '/textbooks/:id' do
    logged_in?
    @textbook = Textbook.find_by_id(params[:id])
    if @textbook.user_id == session[:user_id]
      @owner = true
    else
      @owner = false
    end
    erb :'/textbooks/show'
  end

  get '/textbooks/:id/edit' do
    logged_in?
    @textbook = Textbook.find_by_id(params[:id])
    if current_user.id != @textbook.user_id
      flash[:message] = "You cannot edit another user's item."
      redirect to '/textbooks'
    end
    erb :'/textbooks/edit'
  end

  patch '/textbooks/:id' do
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

  delete '/textbooks/:id/delete' do
    @textbook = Textbook.find_by_id(params[:id])
    @textbook.destroy
    flash[:message] = "Listing successfully deleted."
    redirect to '/textbooks'
  end
end
