require 'sinatra'
require 'pry'
require 'sqlite3'
# require 'sinatra/reloader'
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

  db = SQLite3::Database.new("movies.db")
  searchname = params[:search].gsub(" ","%20").capitalize
  films=[]
  films = db.execute("select * from movies where title is '#{searchname}'")


  if films.length > 0
    puts "Cache HIT"
    films.each do |row|
      @title = row[0]
      @year = row[1]
      @plot = row[6]
      @poster = row[7]
    end
  else
    puts "Cache MISS"
    film = Movie.get_film_info(params[:search].gsub(" ","%20"))
    # binding.pry
    film.save
    @title = film.title
    @year = film.year
    @plot = film.plot
    @poster = film.poster_url
    # Display the movie in the page
  end

  erb :output, :locals => {
    :title => @title,
    :year => @year,
    :plot => @plot,
    :poster => @poster
  } 

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


