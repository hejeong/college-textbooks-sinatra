class UsersController < ApplicationController
  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to "#"
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
end
