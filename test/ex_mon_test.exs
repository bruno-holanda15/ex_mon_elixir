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
end
