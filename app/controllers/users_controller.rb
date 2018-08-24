class UsersController < ApplicationController
  get '/signup' do
    if session[:user_id] != nil
      redirect to '/textbooks'
    end
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to "/textbooks"
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/textbooks'
    else
      redirect to '/login'
    end
  end

  get '/user/:slug' do
    logged_in?
    @user = User.find_by_slug(params[:slug])
    erb :'users/profile_listings'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
