class TextbooksController < ApplicationController
  get '/textbooks' do
    erb :'textbooks/textbooks'
  end

  get '/textbooks/new' do
    erb :'textbooks/new'
  end

end
