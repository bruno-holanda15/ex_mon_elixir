defmodule ExMon.Game.ActionsTest do

  use ExUnit.Case

  alias ExMon.Player
  alias ExMon.Game
  alias ExMon.Game.Actions

  describe "fetch_move/1" do
    test "should return key move" do
      player = Player.build("Percy", :espada, :poseidon, :agua)
      computer = Player.build("Ares", :espada, :fogo, :elixir)
      Game.start(computer, player)

      assert {:ok, :move_rnd} == Actions.fetch_move(:espada)
    end
  end

  describe "attack/1" do
    test "should allow computer attack player" do
      player = Player.build("Percy", :espada, :poseidon, :agua)
      computer = Player.build("Ares", :tri_espada, :fogo, :elixir)
      Game.start(computer, player)

      game = Game.info()
      game
      |> Map.put(:turn, :computer)

      assert :ok == Actions.attack(:move_rnd)
    end

  end

end
