class UsersController < ApplicationController
  # render sign up page
  get '/signup' do
    # can't be seen if logged in
    if session[:user_id] != nil
      redirect to '/textbooks'
    end
    erb :'users/signup'
  end

  # sign up page sends data here
  post '/signup' do
    # input validations
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:message] = "Input fields can't be blank."
      redirect to '/signup'
    end
    # create unique usernames
    if User.exists?(username: params[:username])
      flash[:message] = "Username taken; please try again."
      redirect to '/signup'
    end
    @user = User.create(params)
    # log in
    session[:user_id] = @user.id
    flash[:message] = "Welcome!"
    redirect to "/textbooks"
  end

  # render log in page
  get '/login' do
    # can't be seen by logged in users
    if session[:user_id] != nil
      redirect to '/textbooks'
    end
    erb :'users/login'
  end

  # login page data sent to this post route
  post '/login' do
    # input validations
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:message] = "Input fields can't be blank."
      redirect to '/login'
    end
    @user = User.find_by(username: params[:username])
    # authenticate user and username
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/textbooks'
    else
      flash[:message] = "Incorrect username or password. Please try again."
      redirect to '/login'
    end
  end

  # render user profile page
  get '/user/:slug' do
    # must be logged in
    logged_in?
    @user = User.find_by_slug(params[:slug])
    # finds all purchased textbooks by this user
    @purchased = Textbook.where(buyer_id: @user.id)
    erb :'users/profile_listings'
  end

  # log out
  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
