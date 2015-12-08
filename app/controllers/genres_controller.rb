class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]


  def index
    @genres = Genre.all
  end

  def show
    @genres = Genre.all
  #  @genre = Genre.find(params[:id])
    @movies = @genre.movies
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_url, notice: "Genre successfully created!"
    else
      render :new
    end
  end

  def edit
#    @genre = Genre.find(params[:id])
  end

  def update
  #  @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to genre_path(@genre), notice: "Genre successfully updated!"
    else
      render :edit
    end
  end

  def destroy
  #  @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genres_path, notice: "Genre successfully deleted!"
  end

private

  def genre_params
    params.require(:genre).permit(:name, :slug)
  end

  def set_genre
    @genre = Genre.find_by!(slug: params[:id])
  end


end
