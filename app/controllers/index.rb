enable :sessions

## GETS
get '/' do
  # Look in app/views/index.erb
  @posts = Post.all
  erb :index	
end

get '/login' do
	erb :login
end

get '/newuser' do
	erb :newuser
end

get '/createpost' do
	if session[:user_id]
		erb :createpost
	else 
		@error = "Can't post. Not logged in. Don't SPAM me fucker."
		redirect "/"
	end
end


get '/logout' do
  session.clear
  redirect '/'
end

get '/post/:id' do
	@post = Post.find(params[:id])
	erb :post
end

get '/edit/:id' do
	if session[:user_id]
		@post = Post.find(params[:id])
		erb :edit
	else
		@error = "Can't EDIT. Not logged in. Don't SPAM me fucker."
		session[:error]=@error
		# **** FIGURE OUT WHY CAN'T USE erb: index here???? *****
		redirect "/"
	end
end

####POSTS

post '/' do
	if (@user = User.find_by_email(params[:user_email]).try(:authenticate,params[:user_password]))
		p "troof"
		session[:user_id] = @user.id
		p session[:user_id]
		redirect "/"
	else 
		@error = "You fucked up. Try again."
		redirect "/"
	end
end

post '/newuser' do
	@user = User.new
	@user.email = params[:new_user_email]
	@user.password = params[:new_user_password]
	@user.password_confirmation = params[:new_user_password_validation]
	if @user.save 
		session[:user_id] = @user.id
		redirect"/"
	else
		@error = "Error creating user"
		erb :login
	end
end

post '/createpost' do
	if session[:user_id]
		@post = 			Post.new 
		@user = 			User.find(session[:user_id])
		@post.title = params[:post_subject]
		@post.body = 	params[:post_body]
		@post.save
		@user.posts << @post

		redirect "/"
	else
		@error = "You aren't logged in so can't post."
		erb :index
	end
end

post '/edit/:id' do
	if session[:user_id]
		@post = Post.find(params[:id]) 
		@post.title = params[:post_subject]
		@post.body = params[:post_body]
	  if @post.save
		redirect "/"
		end
	else
		error = "You aren't logged in ERROR"
		session[:error]=error
		redirect "/"
	end
end

post '/delete/:id' do
	if session[:user_id]
		Post.destroy(params[:id]) 
		redirect "/"
	else
		@error = "You aren't logged in so can't delete."
		erb :index
	end
end



