require 'rails_helper'

RSpec.feature "User submits a new song" do
  scenario "they see the page for the individual song" do

    artist = create(:artist)
    song_title = "One Love"

    visit artist_path(artist)
    click_on "New song"
    fill_in "song_title", with: song_title
    click_on "Create Song"

    expect(page).to have_content song_title
    expect(page).to have_link artist.name, href: artist_path(artist)
  end

  context "User data is invalid" do
    scenario "they see an error message" do

      artist = create(:artist)
      visit artist_path(artist)
      click_on "New song"
      click_on "Create Song"
      expect(page).to have_content "Title can't be blank"
    end
  end
end

RSpec.feature "User can edit song" do
  scenario "they can see updated information on show page" do
    artist = create(:artist)
    song = Song.create(title: "All the things she said", artist_id: artist.id)

    visit song_path(song.id)
    click_on "Edit"
    fill_in "song_title", with: "Not Gonna Get Us"
    click_on "Update Song"
    expect(current_path).to eq song_path(song)
    expect(page).to have_content "Not Gonna Get Us"
    expect(page).to have_link artist.name, href: artist_path(artist.id)
  end
end

RSpec.feature "User can visit song index" do
  scenario "songs are sorted and link to their show page" do
    artist = create(:artist)
    song = Song.create(title: "One Love", artist_id: artist.id)
    song2 = Song.create(title: "JahJah", artist_id: artist.id)

    visit artist_path(artist)
    click_on "View songs"
    expect(page).to have_selector("ul li:nth-child(1)", text: song2.title)
    expect(page).to have_selector("ul li:nth-child(2)", text: song.title)

    expect(page).to have_link song.title, href: song_path(song.id)
  end
end
