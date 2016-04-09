require 'rails_helper'


RSpec.feature "User submits a new artist" do
  scenario "they see the page for the individual artist" do
    artist_name            = "Bob Marley"
    artist_image_path      = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    visit artists_path
    click_on "New artist"
    fill_in "artist_name", with: artist_name
    fill_in "artist_image_path", with: artist_image_path
    click_on "Create Artist"

    expect(page).to have_content artist_name
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end

  context "the submitted data is invalid" do
    scenario "they see an error message" do
      artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

      visit artists_path
      click_on "New artist"
      fill_in "artist_image_path", with: artist_image_path
      click_on "Create Artist"

      expect(page).to have_content "Name can't be blank"
    end
  end
end

RSpec.feature "User visits artist index" do
  scenario "they see see each artists name" do
    artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    Artist.create(name: "Bob Marley", image_path: artist_image_path )
    artist = Artist.last

    visit artists_path
    expect(page).to have_content "Bob Marley"
    click_on "Bob Marley"
    expect(current_path).to eq artist_path(artist.id)
  end
end

RSpec.feature "User can update an artist" do
  scenario "they can see the updated information on their show page" do
    artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    Artist.create(name: "Bob Marley", image_path: artist_image_path )
    artist = Artist.last

    visit artist_path(artist)
    expect(page).to have_content "Bob Marley"
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")

    expect(current_path).to eq artist_path(artist.id)
    click_on "Edit"
    expect(current_path).to eq edit_artist_path(artist.id)
    fill_in "artist_name", with: "Bob Barely"
    click_on "Update"
    expect(current_path).to eq artist_path(artist)
    expect(page).not_to have_content "Bob Marley"
    expect(page).to have_content "Bob Barely"
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end
end

RSpec.feature "User can delete artist" do
  scenario "deleting artist redirects me to artists index" do
    artist_image_path = "http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg"

    Artist.create(name: "Bob Marley", image_path: artist_image_path )
    artist = Artist.last

    visit artist_path(artist)
    click_on "Delete"
    expect(current_path).to eq artists_path
    expect(page).not_to have_content "Bob Marley"
  end
end
# As a user
# Given that an artist exists in the database
# When I visit that artist's show page
# And I click on "Delete"
# Then I should be back on the artist index page
# Then I should not see the artist's name
