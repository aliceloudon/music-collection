require('pry-byebug')
require_relative('./models/album.rb')
require_relative('./models/artist.rb')

# Album.delete_all
Artist.delete_all

artist1 = Artist.new({ 'name' => 'Bananarama' })
artist2 = Artist.new({ 'name' => 'Cyndi Lauper' })
artist3 = Artist.new({ 'name' => 'Jennifer Rush' })

artist1.save
artist2.save
artist3.save

album1 = Album.new({
  'title' => 'Deep Sea Skiving',
  'genre' => 'New wave',
  'artist_id' => artist1.id })

album1.save
# album2.save
# album3.save

binding.pry
nil