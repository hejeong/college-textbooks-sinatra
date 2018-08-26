require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # Render Welcome Page
  get "/" do
    # if logged_in, users won't see welcome page
    if session[:user_id] != nil
      redirect to '/textbooks'
    end
    erb :index
  end

  helpers do
    # if not logged_in, redirected to log in page
    # else return true
    def logged_in?
      if session[:user_id] == nil
        flash[:message] = "Please login first."
        redirect to '/login'
      end
      true
    end

    # returns current_user object
    def current_user
      User.find_by_id(session[:user_id])
    end
  end
end
