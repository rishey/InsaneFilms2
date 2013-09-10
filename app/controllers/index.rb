enable :sessions

## GETS
get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/login' do
	erb :login
end

get '/newuser' do
	erb :newuser
end

get '/logout' do
	puts session[:user_id]
  session.clear
  	puts session[:user_id]

  redirect '/'
end

####POSTS

post '/' do
	if (@user = User.find_by_email(params[:user_email]).try(:authenticate,params[:user_password]))
		p "troof"
		session[:user_id] = @user.id
		erb :index
	else 
		@error = "You fucked up. Try again."
		session.clear
		erb :login
	end
end

post '/newuser' do
	@user = User.new
	@user.email = params[:new_user_email]
	@user.password = params[:new_user_password]
	@user.password_confirmation = params[:new_user_password_validation]
	if @user.save 
		session[:user_id] = @user.id
		erb :index
	else
		@error = "Error creating user"
		erb :login
	end
end



