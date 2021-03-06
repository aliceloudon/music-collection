require_relative('album.rb')
require_relative('../db/sql_runner.rb')


class Artist
  attr_reader :id
  attr_accessor :name
  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *;"
    artists = SqlRunner.run(sql)
    @id = artists.first['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map{ |artist| Artist.new(artist) }
  end

  def albums
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end

  def update
    sql = "UPDATE artists SET name = '#{@name}' WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM albums WHERE artist_id = #{@id};"
    SqlRunner.run(sql)
    sql = "DELETE FROM artists WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = #{id};"
    artists = SqlRunner.run(sql)
    return Artist.new(artists.first)    
  end

end