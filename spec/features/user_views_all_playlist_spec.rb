require "rails_helper"

RSpec.feature "User can visit playlist index" do
  scenario "they see playlist name with link " do

    playlist1 = Playlist.create(name: "Slow Jams")
    playlist2 = Playlist.create(name: "Bruised Fruit")
    visit playlists_path
    expect(page).to have_content("Slow Jams")
    expect(page).to have_content("Bruised Fruit")
    expect(page).to have_link playlist1.name, href: playlist_path(playlist1)
    expect(page).to have_link playlist2.name, href: playlist_path(playlist2)
  end

end
