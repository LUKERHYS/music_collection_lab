require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all()
Artist.delete_all()


  artist1 = Artist.new({
    'name' => 'Queen'
    })
  artist1.save()


  album1 = Album.new({
    'title' => 'Night At the Opera',
    'genre' => 'Operatic Rock',
    'artist_id' => artist1.id
    })
  album1.save()


binding.pry
nil
