class TextbooksController < ApplicationController
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
end
