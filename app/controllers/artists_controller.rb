class ArtistsController < ApplicationController
  # index
  def index
    @artists = Artist.all
  end

  # new
  def new
    @artist = Artist.new
  end

  # create
  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      flash[:notice] = "#{@artist.name} was successfully created."
      redirect_to @artist
    else
      render :new
    end
  end

  #show
  def show
    @artist = Artist.find(params[:id])
  end

  # edit
  def edit
    @artist = Artist.find(params[:id])
  end


  # update
  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      flash[:notice] = "#{@artist.name} was successfully updated."
      redirect_to @artist
    else
      render :edit
    end
  end

  # destroy
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect_to artists_path
  end

  private
  def artist_params
    params.require(:artist).permit(:name, :photo_url, :nationality)
  end
end
