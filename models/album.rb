require_relative('artist.rb')
require_relative('../db/sql_runner.rb')

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ('#{@title}', '#{genre}', #{artist_id}) RETURNING *;"
    albums = SqlRunner.run(sql)
    @id = albums.first['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map{ |album| Album.new(album) }
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = #{@artist_id};"
    artists = SqlRunner.run(sql)
    return Artist.new(artists.first)
  end

end