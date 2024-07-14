defmodule Shop.MusicFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Music` context.
  """

  @doc """
  Generate a song.
  """
  def song_fixture(attrs \\ %{}) do
    {:ok, song} =
      attrs
      |> Enum.into(%{
        image: "some image",
        name: "some name"
      })
      |> Shop.Music.create_song()

    song
  end
end
