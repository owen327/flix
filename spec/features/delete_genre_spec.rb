require "spec_helper"

describe "Deleting a genre" do
  before do
    user = User.create!(user_attributes(admin: true))
    sign_in(user)
  end

  it "destroys the genre and shows the genre listing without the deleted genre" do
    genre = Genre.create!(name: "Newgenrename")
    movie = Movie.create!(movie_attributes)
    movie.genres << genre

    visit genre_path(genre)

    click_link "Delete"

    expect(current_path).to eq(genres_path)
    expect(page).not_to have_content("Newgenrename")
    expect(page).to have_content("Genre successfully deleted!")


  end


end
