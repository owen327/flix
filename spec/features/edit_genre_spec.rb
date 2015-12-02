require "spec_helper"

describe "Editing a genre" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end

  it "updates the genre and shows the genre's updated details" do
    genre = Genre.create!(name: "Action")

    visit edit_genre_path(genre)

    fill_in "Name", with: "New name"

    click_button "Update Genre"

    expect(current_path).to eq(genre_path(genre))

    expect(page).to have_content("New name")

  end

  it "does not update the genre if it's invalid" do
    genre1 = Genre.create!(name: "Action")
    genre2 = Genre.create!(name: "Action2")

    visit edit_genre_path(genre2)

    fill_in "Name", with: "Action"

    click_button "Update Genre"

    expect(page).to have_content("error")

  end


end
