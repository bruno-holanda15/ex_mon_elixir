defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message(%{status: :started} = info) do
    IO.puts("\n========== The game has started! ==============\n")
    IO.inspect(info)
    IO.puts("\n--------------------------------------\n")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n========== It`s #{player} turn. ==============\n")
    IO.inspect(info)
    IO.puts("\n--------------------------------------\n")
  end

  def print_round_message(%{status: :game_over, turn: player} = info) do
    IO.puts("\n========== The game is over! ==============\n")
    IO.inspect(info)
    IO.puts("\n--------------------------------------\n")
  end

  def print_wrong_move_message(move) do
    IO.puts("\n========== Invalid move: #{move} ==============\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n========== The player attacked the computer dealing #{damage} ==============\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n========== The computer attacked the player dealing #{damage} ==============\n")
  end

  def print_move_message(:player, :heal, damage) do
    IO.puts("\n========== The player healed himself by #{damage} points ==============\n")
  end

  def print_move_message(:computer, :heal, damage) do
    IO.puts("\n========== The computer healed himself by #{damage} points ==============\n")
  end
end
