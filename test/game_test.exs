defmodule ExMon.GameTest do
  alias ExMon.{Game, Player}
  use ExUnit.Case

  describe "start/2" do
    test "when a player and computer is provided return a game started" do
      player = Player.build("Jose", :kick, :punch, :heal)
      computer = Player.build("Robotnik", :kick, :punch, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "when info is called return currenct game state" do
      player = Player.build("Jose", :kick, :punch, :heal)
      computer = Player.build("Robotnik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %{
        player: %Player{
          life: 100,
          name: "Jose",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
        },
        computer: %Player{
          life: 100,
          name: "Robotnik",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "when update is called return the game state updated" do
      player = Player.build("Jose", :kick, :punch, :heal)
      computer = Player.build("Robotnik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          name: "Robotnik",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
        },
        player: %Player{
          life: 100,
          name: "Jose",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        player: %Player{
          life: 100,
          name: "Jose",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
        },
        computer: %Player{
          life: 80,
          name: "Robotnik",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "return player info" do
      player = Player.build("Jose", :kick, :punch, :heal)
      computer = Player.build("Robotnik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        name: "Jose",
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "should return current turn" do
      player = Player.build("Jose", :kick, :punch, :heal)
      computer = Player.build("Robotnik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = :player

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "when provided a player atom return its data" do
      player = Player.build("Jose", :kick, :punch, :heal)
      computer = Player.build("Robotnik", :kick, :punch, :heal)

      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        name: "Robotnik",
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick}
      }

      assert expected_response == Game.fetch_player(:computer)
    end
  end
end
