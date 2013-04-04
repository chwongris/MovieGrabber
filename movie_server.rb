require 'sinatra'
require 'pry'
# require 'rack-flash'
# use Rack::Flash
require_relative 'movies'



get '/' do
  erb :index
  redirect '/login'
end

get '/film' do
erb :search
end

post '/film' do

  # Search for a Movie
  # HINT - what is in params ?
  output = Movie.get_film_info(params[:search].gsub(" ","%20"))

  title = output.title
  year = output.year
  plot = output.plot
  poster = output.poster_url


  erb :output, :locals => {
    :title => title,
    :year => year,
    :plot => plot,
    :poster => poster

  } 
  # Display the movie in the page
end

# post '/login' do
#   unless params[:password] == "coolbananas"
#      flash[:notice] = "Sorry please try again"
#   else

#   end
# end

get '/login' do
  erb :login

end

before '/new' do
  unless params[:password] == "coolbananas"
        redirect '/login'
      end
    end

get '/new' do
  # erb :new, :locals => { :user => @user }
  redirect '/film'
end

post '/new' do
  redirect '/film'
# session[:current_user] = "Dan"
# erb :new
end





