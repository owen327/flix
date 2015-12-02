require "spec_helper"

describe "Viewing the list of genres" do
  it "shows the genres" do
    genre1 = Genre.create!(name: "Action")
    genre2 = Genre.create!(name: "Comedy")
    genre3 = Genre.create!(name: "Musical")

    visit genres_path

    expect(page).to have_text(genre1.name)
    expect(page).to have_text(genre2.name)
    expect(page).to have_text(genre3.name)
  end




end
