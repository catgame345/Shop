defmodule ShopWeb.SongControllerTest do
  use ShopWeb.ConnCase

  import Shop.MusicFixtures

  @create_attrs %{name: "some name", image: "some image"}
  @update_attrs %{name: "some updated name", image: "some updated image"}
  @invalid_attrs %{name: nil, image: nil}

  describe "index" do
    test "lists all songs", %{conn: conn} do
      conn = get(conn, ~p"/songs")
      assert html_response(conn, 200) =~ "Listing Songs"
    end
  end

  describe "new song" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/songs/new")
      assert html_response(conn, 200) =~ "New Song"
    end
  end

  describe "create song" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/songs", song: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/songs/#{id}"

      conn = get(conn, ~p"/songs/#{id}")
      assert html_response(conn, 200) =~ "Song #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/songs", song: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Song"
    end
  end

  describe "edit song" do
    setup [:create_song]

    test "renders form for editing chosen song", %{conn: conn, song: song} do
      conn = get(conn, ~p"/songs/#{song}/edit")
      assert html_response(conn, 200) =~ "Edit Song"
    end
  end

  describe "update song" do
    setup [:create_song]

    test "redirects when data is valid", %{conn: conn, song: song} do
      conn = put(conn, ~p"/songs/#{song}", song: @update_attrs)
      assert redirected_to(conn) == ~p"/songs/#{song}"

      conn = get(conn, ~p"/songs/#{song}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, song: song} do
      conn = put(conn, ~p"/songs/#{song}", song: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Song"
    end
  end

  describe "delete song" do
    setup [:create_song]

    test "deletes chosen song", %{conn: conn, song: song} do
      conn = delete(conn, ~p"/songs/#{song}")
      assert redirected_to(conn) == ~p"/songs"

      assert_error_sent 404, fn ->
        get(conn, ~p"/songs/#{song}")
      end
    end
  end

  defp create_song(_) do
    song = song_fixture()
    %{song: song}
  end
end
