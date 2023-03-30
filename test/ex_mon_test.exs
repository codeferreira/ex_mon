defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "when provided correct values return a player struct" do
      player = ExMon.create_player("Jose", :punch, :kick, :heal)

      expected_response = %ExMon.Player{
        name: "Jose",
        life: 100,
        moves: %{move_avg: :kick, move_rnd: :punch, move_heal: :heal}
      }

      assert expected_response == player
    end
  end

  describe "start_game/1" do
    test "when provided a player return a game started" do
      player = ExMon.create_player("Jose", :punch, :kick, :heal)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      expected_response = %{
        player: %ExMon.Player{
          life: 100,
          name: "Jose",
          moves: %{move_avg: :kick, move_rnd: :punch, move_heal: :heal}
        },
        computer: %ExMon.Player{
          life: 100,
          name: "Robotnik",
          moves: %{move_avg: :kick, move_rnd: :punch, move_heal: :heal}
        },
        status: :started,
        turn: :player
      }

      assert expected_response == ExMon.Game.info()
      assert messages =~ "The game started"
    end
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("Jose", :punch, :kick, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, make players move and computer make a move too" do
      messages =
        capture_io(fn ->
          assert ExMon.make_move(:punch) == :ok
        end)

      assert messages =~ "Jose attacked Robotnik with punch"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move"
      assert messages =~ "Move: wrong"
    end
  end
end
