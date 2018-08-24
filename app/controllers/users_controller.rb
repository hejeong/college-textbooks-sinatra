class UsersController < ApplicationController
  get '/signup' do
    if session[:user_id] != nil
      redirect to '/textbooks'
    end
    erb :'users/signup'
  end

  post '/signup' do
    if User.exists?(username: params[:username])
      flash[:message] = "Username taken; please try again."
      redirect to '/signup'
    end
    @user = User.create(params)
    session[:user_id] = @user.id
    flash[:message] = "Welcome!"
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
      flash[:message] = "Incorrect username or password. Please try again."
      redirect to '/login'
    end
  end

  get '/user/:slug' do
    logged_in?
    @user = User.find_by_slug(params[:slug])
    @purchased = Textbook.where(buyer_id: @user.id)
    erb :'users/profile_listings'
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
