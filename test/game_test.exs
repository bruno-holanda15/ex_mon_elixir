defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Blake", :espada, :poseidon, :agua)
      computer = Player.build("Megatron", :move_avg, :move_rnd, :move_heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "gets info after started the game" do
      player = Player.build("Blake", :espada, :poseidon, :agua)
      computer = Player.build("Megatron", :move_avg, :move_rnd, :move_heal)
      Game.start(computer, player)

      expected_info = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :poseidon, move_rnd: :espada, move_heal: :agua},
          name: "Blake"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :move_rnd, move_rnd: :move_avg, move_heal: :move_heal},
          name: "Megatron"
        },
        turn: :player
      }

      assert expected_info == Game.info()
    end
  end

  describe "update/1" do
    test "updates game after started" do
      player = Player.build("Blake", :espada, :poseidon, :agua)
      computer = Player.build("Megatron", :move_avg, :move_rnd, :move_heal)
      Game.start(computer, player)

      expected_info = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :poseidon, move_rnd: :espada, move_heal: :agua},
          name: "Blake"
        },
        computer: %Player{
          life: 100,
          moves: %{move_avg: :move_rnd, move_rnd: :move_avg, move_heal: :move_heal},
          name: "Megatron"
        },
        turn: :player
      }

      assert expected_info == Game.info()

      new_state = %{
        status: :started,
        player: %Player{
          life: 38,
          moves: %{move_avg: :poseidon, move_rnd: :espada, move_heal: :agua},
          name: "Blake"
        },
        computer: %Player{
          life: 15,
          moves: %{move_avg: :move_rnd, move_rnd: :move_avg, move_heal: :move_heal},
          name: "Megatron"
        },
        turn: :player
      }

      Game.update(new_state)

      expected_info = %{new_state | status: :continue, turn: :computer}

      assert expected_info == Game.info()
    end
  end

  describe "player/0" do
    test "gets player info" do
      player = Player.build("Blake", :espada, :poseidon, :agua)
      computer = Player.build("Megatron", :move_avg, :move_rnd, :move_heal)
      Game.start(computer, player)

      expected_player = %Player{
        life: 100,
        moves: %{move_avg: :poseidon, move_rnd: :espada, move_heal: :agua},
        name: "Blake"
      }

      assert expected_player == Game.player()
    end
  end

  describe "turn/0" do
    test "gets turn after started" do
      player = Player.build("Blake", :espada, :poseidon, :agua)
      computer = Player.build("Megatron", :move_avg, :move_rnd, :move_heal)
      Game.start(computer, player)

      assert :player == Game.turn()
    end

    test "gets turn after updated" do
      player = Player.build("Blake", :espada, :poseidon, :agua)
      computer = Player.build("Megatron", :move_avg, :move_rnd, :move_heal)
      Game.start(computer, player)

      new_state = %{
        status: :started,
        player: %Player{
          life: 38,
          moves: %{move_avg: :poseidon, move_rnd: :espada, move_heal: :agua},
          name: "Blake"
        },
        computer: %Player{
          life: 15,
          moves: %{move_avg: :move_rnd, move_rnd: :move_avg, move_heal: :move_heal},
          name: "Megatron"
        },
        turn: :player
      }

      Game.update(new_state)
      assert :computer == Game.turn()
    end
  end
end
