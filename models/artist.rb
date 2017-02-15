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

end