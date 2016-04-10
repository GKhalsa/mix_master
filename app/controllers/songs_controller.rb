class SongsController < ApplicationController

  def index
    unsorted_songs = Song.all
    @songs = unsorted_songs.order(:title)
  end

  def new
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new(song_params)
    if @song.save
      redirect_to song_path(@song)
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    if @song.update(song_params)
      redirect_to song_path(@song)
    else
      render :edit
    end
  end

  def show
    @song = Song.find(params[:id])
  end

  private

  def song_params
    params.require(:song).permit(:title)
  end
end
