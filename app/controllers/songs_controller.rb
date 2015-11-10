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
    @song = Song.create!(song_params.merge(artist: @artist))
    redirect_to artist_song_path(@artist, @song)
  end

  #show
  def show
    @song = Song.find(params[:id])
  end

  # edit
  def edit
    @song = Song.find(params[:id])
  end

  # update
  def update
    @song = Song.find(params[:id])
    @artist = Artist.find(params[:artist_id])
    @song.update(song_params.merge(artist: @artist))
    redirect_to artist_song_path(@song.artist, @song)
  end

  # destroy
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to songs_path
  end

  # add favorite
  def add_favorite
    @song = Song.find(params[:id])
    @artist = @song.artist
    @song.favorites.create(user: current_user)
    redirect_to artist_path(@artist)
  end

  # remove favorite
  def remove_favorite
    @song = Song.find(params[:id])
    @artist = @song.artist
    @song.favorites.where(user: current_user).destroy_all
    redirect_to artist_path(@artist)
  end

  private
  def song_params
    params.require(:song).permit(:title, :album, :preview_url, :artist_id)
  end
end
