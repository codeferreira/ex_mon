defmodule ExMon.Game.Status do
  def print_round_message(%{status: :started} = info) do
    IO.puts("\n====== The game started ======\n")
    IO.inspect(info)
    IO.puts("----------------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n====== It's #{player} turn ======\n")
    IO.inspect(info)
    IO.puts("----------------------------")
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n====== Game Over ======\n")
    IO.inspect(info)
    IO.puts("----------------------------")
  end

  def print_invalid_move_message(move) do
    IO.puts("\n====== Invalid move ======\n")
    IO.puts("Move: #{move}")
    IO.puts("----------------------------")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n====== Player attacked Robotnik dealing #{damage} damage ======\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n====== Robotnik attacked player dealing #{damage} damage ======\n")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("\n====== The #{player} healed #{life} life points ======\n")
  end
end
