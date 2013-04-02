# db.execute("create table movies (id integer Primary Key, title varchar, year integer, director varchar, imdbRating float, plot varchar)")

class Movie 
  attr_accessor :title
  attr_accessor :year
  attr_accessor :director
  attr_accessor :imdbRating
  attr_accessor :plot
  # Add attr_accessors for the values you want to store...


  def self.get_film_info(name)    
    @@db = SQLite3::Database.new("test/test.db")
    imdb_data = HTTParty.get("http://www.omdbapi.com/?t=#{name}")
    movie_info = JSON(imdb_data)
# a = @@db.execute("select * from movies where title is '#{name}'")
# binding.pry
    # if  @@db.execute("select * from movies where title is '#{name}'").[ == []
    # Create a Movie object...
      m = Movie.new
      m.title = movie_info["Title"]
      m.year = movie_info["Year"]
      m.director = movie_info["Director"]
      m.imdbRating= movie_info["imdbRating"]
      m.plot= movie_info["Plot"]
      

    # Fill in the attributes...

    # Store me in a SQLite3 database...    
    sql = "Insert into movies (title, year, director, imdbRating, plot) values (?,?,?,?,?)"
# binding.pry
    @@db.execute(sql, m.title, m.year, m.director, m.imdbRating, m.plot)
    # else
    # end
  end

end