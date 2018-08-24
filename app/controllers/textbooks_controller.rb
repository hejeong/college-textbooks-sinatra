class TextbooksController < ApplicationController
  use Rack::Flash

  get '/textbooks' do
    erb :'textbooks/textbooks'
  end

  get '/textbooks/new' do
    erb :'textbooks/new'
  end

  post '/textbooks' do
    @textbook = Textbook.new(title: params[:title], author: params[:author], price: params[:price])
    @textbook.user_id = session[:user_id]
    @textbook.save
    redirect to "/textbooks/#{@textbook.id}"
  end

  get '/textbooks/:id' do
    @textbook = Textbook.find_by_id(params[:id])
    erb :'/textbooks/show'
  end

  get '/textbooks/:id/edit' do
    @textbook = Textbook.find_by_id(params[:id])
    erb :'/textbooks/edit'
  end

  patch '/textbooks/:id' do
    @textbook = Textbook.find_by_id(params[:id])
    @textbook.update(title: params[:title], author: params[:author], price: params[:price])
    redirect to "textbooks/#{@textbook.id}"
  end

  delete '/textbooks/:id/delete' do
    @textbook = Textbook.find_by_id(params[:id])
    @textbook.destroy
    flash[:message] = "Listing successfully deleted."
    redirect to '/textbooks'
  end
end
