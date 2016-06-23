require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
  	erb :homepage
  end

 #  get '/login' do
 #  	erb :login
 #  end

 #  post '/login' do
 #  	@user = User.find_by(username: params[:username])
	# if @user && @user.authenticate(params[:password])
		
 #  		redirect to '/tweets'
 #  	else
 #  		session[:error] = "Something went wrong"
 #  		redirect to '/login'
 #  	end
 #  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by(session[:user_id])
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/signup' do
  	if logged_in?
  		redirect 'tweets'
  	else
  		erb :signup
  	end
  end

  post '/signup' do
  	@user = User.new(params["user"])
  	if @user.save
  		session[:user_id] = @user.id
  		redirect '/tweets'
 		
 	else
 		redirect '/signup'	
  	end
  	
  end

  get '/failure' do
  	erb :failure
  end

 
  get '/tweets/new' do
  	erb :'/tweets/new'
  end

  post '/tweets' do
  end

  get '/tweets/:id' do
  	erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
  	erb :'/tweets/edit'
  end

  post '/tweets/:id' do
  end

  get '/tweets/:id' do
  	erb :'/tweets/show'
  end

  helpers do
  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		user = User.find(session[:user_id])
  	end
  end

end
