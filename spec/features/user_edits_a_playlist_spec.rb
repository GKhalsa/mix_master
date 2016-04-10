require "rails_helper"

RSpec.feature "user can edit a playlist" do
  scenario "they can see an updated playlist with new params" do
    song_one, song_two, song_three = create_list(:song, 3)
    playlist = Playlist.create(name: "Slow Jams")
    PlaylistSong.create(song_id: song_three.id, playlist_id: playlist.id)

    visit playlist_path(playlist)
    expect(page).to have_content("Slow Jams")
    expect(page).to have_content("#{song_three.title}")
    click_on("Edit")

    fill_in "playlist_name", with: "Bruised Fruit"
    check("song-#{song_one.id}")
    check("song-#{song_two.id}")
    uncheck("song-#{song_three.id}")
    click_on "Update Playlist"

    expect(page).to have_content("Bruised Fruit")
    expect(page).not_to have_content("Slow Jams")
    expect(page).to have_content("#{song_one.title}")
    expect(page).not_to have_content("#{song_three.title}")
  end
end
