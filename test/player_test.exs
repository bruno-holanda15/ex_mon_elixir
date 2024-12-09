defmodule ExMon.PlayerTest do
  use ExUnit.Case

  alias ExMon.Player

  describe "build/4" do
    test "should return player" do
      name = "Sasuke"
      move_a = :chidori
      move_r = :sharingan
      move_h = :sakura_chan
      expected_player = %ExMon.Player{
        life: 100,
        moves: %{
          move_avg: move_a,
          move_rnd: move_r,
          move_heal: move_h
        },
        name: name
      }

      assert expected_player == Player.build(name, move_r, move_a, move_h)
    end
  end
end
