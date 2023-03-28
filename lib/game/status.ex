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
end
