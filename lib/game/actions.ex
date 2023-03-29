defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.Attack
  alias ExMon.Game.Status

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  def perform_move({:error, move}), do: Status.print_invalid_move_message(move)

  def perform_move({:ok, move}) do
    case move do
      :move_heal -> "cura"
      move -> attack(move)
    end

    Status.print_round_message(Game.info())
  end

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end
end
