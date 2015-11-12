class SongsController < ApplicationController
  # index
  def index
    @songs = Song.all
  end

  # new
  def new
    @artist = Artist.find(params[:artist_id])
    @song = Song.new
  end

  # create
  def create
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new(song_params)
    if @song.save
      flash[:notice] = "#{@song.title} was successfully created."
      redirect_to @song
    else
      render :new
    end
  end

  #show
  def show
    @song = Song.find(params[:id])
    @artist = @song.artist
  end

  # edit
  def edit
    @song = Song.find(params[:id])
    @artist = @song.artist
  end

  # update
  def update
    @song = Song.find(params[:id])
    @artist = @song.artist
    if @song.update(song_params)
      flash[:notice] = "#{@song.title} was successfully updated."
      redirect_to @song
    else
      render :edit
    end
  end

  # destroy
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to @song.artist
  end

  # add favorite
  def add_favorite
    @song = Song.find(params[:id])
    @song.favorites.create(user: current_user)
    redirect_to @song.artist
  end

  # remove favorite
  def remove_favorite
    @song = Song.find(params[:id])
    @song.favorites.where(user: current_user).destroy_all
    redirect_to @song.artist
  end

  private
  def song_params
    params.require(:song).permit(:title, :album, :preview_url, :artist_id)
  end
end
