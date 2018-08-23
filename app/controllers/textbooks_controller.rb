class TextbooksController < ApplicationController
  get '/textbooks' do
    erb :'textbooks/texbooks'
  end


end
