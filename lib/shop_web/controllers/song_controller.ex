defmodule ShopWeb.SongController do
  use ShopWeb, :controller

  alias Shop.Music
  alias Shop.Music.Song

  def index(conn, _params) do
    songs = Music.list_songs()
    render(conn, :index, songs: songs)
  end

  def new(conn, _params) do
    changeset = Music.change_song(%Song{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"song" => song_params}) do
    case Music.create_song(song_params) do
      {:ok, song} ->
        conn
        |> put_flash(:info, "Song created successfully.")
        |> redirect(to: ~p"/songs/#{song}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    song = Music.get_song!(id)
    render(conn, :show, song: song)
  end

  def edit(conn, %{"id" => id}) do
    song = Music.get_song!(id)
    changeset = Music.change_song(song)
    render(conn, :edit, song: song, changeset: changeset)
  end

  def update(conn, %{"id" => id, "song" => song_params}) do
    song = Music.get_song!(id)

    case Music.update_song(song, song_params) do
      {:ok, song} ->
        conn
        |> put_flash(:info, "Song updated successfully.")
        |> redirect(to: ~p"/songs/#{song}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, song: song, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    song = Music.get_song!(id)
    {:ok, _song} = Music.delete_song(song)

    conn
    |> put_flash(:info, "Song deleted successfully.")
    |> redirect(to: ~p"/songs")
  end
end
