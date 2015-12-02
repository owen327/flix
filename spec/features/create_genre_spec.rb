require "spec_helper"

describe "Creating a new genre" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end

  it "creates a new genre and shows the new genre's movies" do
    visit new_genre_path

    fill_in "Name", with: "Genre name"

    click_button 'Create Genre'

    expect(current_path).to eq(genres_path)

    expect(page).to have_text('Genre successfully created!')
    expect(page).to have_text("Genre name")
  end

  it "does not save the genre if it's invalid" do
    visit new_genre_url

    expect {
      click_button 'Create Genre'
    }.not_to change(Genre, :count)

    expect(page).to have_text('error')
  end
end
