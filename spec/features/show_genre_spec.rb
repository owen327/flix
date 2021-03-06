require "spec_helper"

describe "Viewing an individual genre" do

  it "shows all movies belonging to that genre" do
    genre = Genre.create!(name: "Superhero")
    movie1 = Movie.create!(title: "Iron Man",
                            rating: "PG-13",
                            total_gross: 318412101.00,
                            description: "Tony Stark builds an armored suit to fight the throes of evil",
                            released_on: "2008-05-02",
                            cast: "Robert Downey Jr., Gwyneth Paltrow and Terrence Howard",
                            director: "Jon Favreau",
                            duration: "126 min",
                            image_file_name: "ironman.jpg")

    movie2 = Movie.create!(title: "Superman",
                            rating: "PG",
                            total_gross: 134218018.00,
                            description: "Clark Kent grows up to be the greatest super-hero",
                            released_on: "1978-12-15",
                            cast: "Christopher Reeve, Margot Kidder and Gene Hackman",
                            director: "Richard Donner",
                            duration: "143 min",
                            image_file_name: "superman.jpg")

    movie3 = Movie.create!(title: "Spider-Man",
                            rating: "PG-13",
                            total_gross: 403706375.00,
                            description: "Peter Parker gets bit by a genetically modified spider",
                            released_on: "2002-05-03",
                            cast: "Tobey Maguire, Kirsten Dunst and Willem Dafoe",
                            director: "Sam Raimi",
                            duration: "121 min",
                            image_file_name: "spiderman.jpg")
    movie1.genres << genre
    movie2.genres << genre

    visit genre_path(genre)

    expect(page).to have_text(movie1.title)
    expect(page).to have_text(movie2.title)
    expect(page).not_to have_text(movie3.title)
    expect(page).to have_text(movie1.rating)
    expect(page).to have_text(movie1.description[0..10])
    expect(page).to have_text(movie1.released_on.year)
    expect(page).to have_text("$318,412,101.00")

  end

  it "shows a list of genres in the sidebar" do
    genre1 = Genre.create!(name: "Action")
    genre2 = Genre.create!(name: "Comedy")
    visit root_url

    within("aside#sidebar") do
      expect(page).to have_text(genre1.name)
      expect(page).to have_text(genre2.name)
    end
  end

  it "has an SEO-friendly URL" do
    genre = Genre.create!(name: "Action")

    visit genre_url(genre)

    expect(current_path).to eq("/genres/action")
  end


end
