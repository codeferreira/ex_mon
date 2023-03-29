defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message do
    IO.puts("\n====== The game started ======\n")
    IO.inspect(Game.info())
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

  def print_move_message(:player, :heal, damage) do
    IO.puts("\n====== Player healed #{damage} life ======\n")
  end
end
