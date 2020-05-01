require 'rubygems'
require 'sinatra'
require './secure.rb'

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end

get '/' do
  erb '<a href="/sign_on">New user</a>'
end

get '/sign_on' do
  erb :sign_on
end

get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  if user_exist?(params['username'])
    session[:identity] = params['username']
  else
    erb 'Unknown username or password'
  end
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

post '/sign_on' do
  if user_exist?(params['username'])
    session[:previous_url] = request.path
    @error = "Sorry,  username #{params['username']} already exist" + request.path
    halt erb :sign_on
  elsif params['userpass']!=params['confirmpass']
    session[:previous_url] = request.path
    @error = "Sorry, password and confirmation is not match" + request.path
    halt erb :sign_on
  else
    add_user(params['username'], params['password'])
    erb :login_form
  end
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/secure/place' do
  erb 'This is a secret place that only <%=session[:identity]%> has access to!'
end
