require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  ## CLASS METHODS

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artist.new(artist)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM
    artists
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artists_hash = results.first
    artist = Artist.new(artists_hash)
    return artist
  end

##INSTANCE METHODS

def save()
    sql = "INSERT INTO artists (
    name
  ) VALUES (
    $1
  ) RETURNING id"
  values = [@name]
  results = SqlRunner.run(sql, values)
  @id = results[0]['id'].to_i
end

def albums()
  sql = "SELECT * FROM albums
  WHERE artist_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return results.map{|album| Album.new(album)}
end

def update()
  sql = "UPDATE albums SET (
  title, genre, artist_id
  ) = (
  $1, $2, $3
  ) WHERE id = $4"
  values = [@title, @genre, @artist_id, @id]
  SqlRunner.run(sql, values)
end

end
