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

# As a user
# Given that a playlist and songs exist in the database
# When I visit that playlist's show page
# And I click on "Edit"
# And I enter a new playlist name
# And I select an additional song
# And I uncheck an existing song
# And I click on "Update Playlist"
# Then I should see the playlist's updated name
# And I should see the name of the newly added song
# And I should not see the name of the removed song
