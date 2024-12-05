defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "return created player" do
      expected_player = %Player{
        life: 100,
        moves: %{
          move_avg: :kick,
          move_rnd: :punch,
          move_heal: :heal
        },
        name: "PlayerT"
      }

      assert expected_player == ExMon.create_player("PlayerT", :punch, :kick, :heal)
    end
  end

  describe "start_game/1" do
    test "when game is started, returns a message" do
      player = Player.build("PlayerT", :punch, :kick, :heal)

      message =
        capture_io(fn ->
          assert :ok == ExMon.start_game(player)
        end)

      assert message =~ "The game has started"
      assert message =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("PlayerT", :punch, :kick, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end
    test "when player makes a move, returns a message with game infos" do

      message = capture_io(fn ->
        ExMon.make_move(:kick)
      end)

      assert message =~ "The player attacked the computer"
      assert message =~ "It's computer turn"
      assert message =~ "status: :continue"
    end

    test "when player makes a invalid move, returns a invalid message" do

      message = capture_io(fn ->
        ExMon.make_move(:pool)
      end)

      assert message =~ "Invalid move: pool"
    end
  end
end
