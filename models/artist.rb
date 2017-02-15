require_relative ('album.rb')
require_relative ('../db/sql_runner.rb')


class Artist

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *;"
    artists = SqlRunner.run(sql)
    @id = artists.first['id'].to_i
  end

end