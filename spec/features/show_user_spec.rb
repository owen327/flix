require 'spec_helper'

describe "Viewing a user's profile page" do

  it "shows the user's details" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_url(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end

  it "shows the user's favourite movies in the sidebar" do
    user = User.create!(user_attributes)
    movie = Movie.create!(movie_attributes)
    user.favourite_movies << movie

    sign_in(user)

    visit user_url(user)

    within("aside#sidebar") do
      expect(page).to have_text(movie.title)
    end
  end

  it "includes the user's name in the page title" do
    user = User.create!(user_attributes)

    sign_in(user)

    visit user_url(user)

    expect(page).to have_title("Flix - #{user.name}")
  end

  it "has an SEO-friendly URL" do
    user = User.create!(user_attributes(username: "username"))

    sign_in(user)

    visit user_url(user)

    expect(current_path).to eq("/users/username")
  end

end
