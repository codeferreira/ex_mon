defmodule ExMon.PlayerTest do
  alias ExMon.Player
  use ExUnit.Case

  describe "build/4" do
    test "when passing all user data returns a player struct" do
      player = Player.build("Ash", :kick, :punch, :heal)

      expected_response = %Player{
        name: "Ash",
        moves: %{
          move_rnd: :kick,
          move_avg: :punch,
          move_heal: :heal
        },
        life: 100
      }

      assert player == expected_response
    end
  end
end
