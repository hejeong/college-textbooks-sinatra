class TextbooksController < ApplicationController
  get '/textbooks' do
    erb :'textbooks/texbooks'
  end

  get '/textbooks/new' do
    erb :'textbooks/new'
  end

end
