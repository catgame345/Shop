defmodule Shop.MusicTest do
  use Shop.DataCase

  alias Shop.Music

  describe "songs" do
    alias Shop.Music.Song

    import Shop.MusicFixtures

    @invalid_attrs %{name: nil, image: nil}

    test "list_songs/0 returns all songs" do
      song = song_fixture()
      assert Music.list_songs() == [song]
    end

    test "get_song!/1 returns the song with given id" do
      song = song_fixture()
      assert Music.get_song!(song.id) == song
    end

    test "create_song/1 with valid data creates a song" do
      valid_attrs = %{name: "some name", image: "some image"}

      assert {:ok, %Song{} = song} = Music.create_song(valid_attrs)
      assert song.name == "some name"
      assert song.image == "some image"
    end

    test "create_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Music.create_song(@invalid_attrs)
    end

    test "update_song/2 with valid data updates the song" do
      song = song_fixture()
      update_attrs = %{name: "some updated name", image: "some updated image"}

      assert {:ok, %Song{} = song} = Music.update_song(song, update_attrs)
      assert song.name == "some updated name"
      assert song.image == "some updated image"
    end

    test "update_song/2 with invalid data returns error changeset" do
      song = song_fixture()
      assert {:error, %Ecto.Changeset{}} = Music.update_song(song, @invalid_attrs)
      assert song == Music.get_song!(song.id)
    end

    test "delete_song/1 deletes the song" do
      song = song_fixture()
      assert {:ok, %Song{}} = Music.delete_song(song)
      assert_raise Ecto.NoResultsError, fn -> Music.get_song!(song.id) end
    end

    test "change_song/1 returns a song changeset" do
      song = song_fixture()
      assert %Ecto.Changeset{} = Music.change_song(song)
    end
  end
end
