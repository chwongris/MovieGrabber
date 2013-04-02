require 'test/unit'
require 'sqlite3'
require 'httparty'
require 'json'
require 'pry'
require_relative '../movies'

class MovieGrabberTest < Test::Unit::TestCase

 def setup
    @@db = SQLite3::Database.new("test/test.db")
  end



  def test_get_film_info_method
    Movie.get_film_info("jaws")
    movies = []
    # Don't forget to create your movies table first, using sqlite3...
    movies = @@db.execute("select * from movies")
    
    assert_equal 1, movies.length
    assert_equal "Jaws", movies.first[1] # Note, this can change if you want/need
    # Add other parts to your test here...

  end

  def teardown
    @@db.close
  end
end