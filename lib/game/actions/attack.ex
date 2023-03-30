defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_avg_power 18..25
  @move_rnd_power 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_damage(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent, move, damage)
  end

  defp calculate_damage(:move_avg), do: Enum.random(@move_avg_power)
  defp calculate_damage(:move_rnd), do: Enum.random(@move_rnd_power)

  defp calculate_total_life(life, damage) when life - damage < 0, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent, move, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(opponent, move, damage)
  end

  defp update_game(player, opponent, move, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    opponent_name = player |> Map.get(:name)
    move_name = player |> Map.get(:moves) |> Map.get(move)

    player_name =
      case opponent do
        :player -> Game.fetch_player(:computer) |> Map.get(:name)
        :computer -> Game.fetch_player(:player) |> Map.get(:name)
      end

    Status.print_move_message(
      player_name,
      opponent_name,
      :attack,
      move_name,
      damage
    )
  end
end
