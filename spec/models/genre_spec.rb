require "spec_helper"

describe "A genre" do

  it "generates a slug when it's created" do
    genre = Genre.create!(name: "Action")

    expect(genre.slug).to eq("action")
  end

  it "requires a unique title" do
    genre1 = Genre.create!(name: "Action")

    genre2 = Genre.new(name: genre1.name)
    genre2.valid? # populates errors
    expect(genre2.errors[:name].first).to eq("has already been taken")
  end

  it "requires a unique slug" do
    genre1 = Genre.create!(name: "Action")

    genre2 = Genre.new(slug: genre1.slug)
    genre2.valid? # populates errors
    expect(genre2.errors[:slug].first).to eq("has already been taken")
  end

end
