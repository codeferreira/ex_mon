defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotnik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> Actions.perform_move()

    computer_move(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}

    Actions.perform_move(move)
  end

  defp computer_move(_), do: :ok
end
