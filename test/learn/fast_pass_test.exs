defmodule Learn.FastPassTest do
  use ExUnit.Case, async: true

  alias Learn.FastPass

  describe "new/2" do
    test "creates a new fast pass with valid input" do
      {:ok, ride} = Learn.Ride.new("Roller Coaster", min_height_ft: 5)

      assert {:ok, %FastPass{ride: ^ride, time: ~U[2024-01-01 12:00:00Z]}} =
               FastPass.new(ride, ~U[2024-01-01 12:00:00Z])
    end

    test "returns error for invalid input" do
      assert {:error, [%Zoi.Error{path: [:ride], message: "invalid type: expected struct"}]} =
               FastPass.new(123, ~U[2024-01-01 12:00:00Z])
    end
  end

  describe "eq?/2" do
    test "returns true for fast passes with the same time" do
      {:ok, ride} = Learn.Ride.new("Ferris Wheel", min_height_ft: 3)
      {:ok, fp1} = FastPass.new(ride, ~U[2024-01-01 12:00:00Z])
      {:ok, fp2} = FastPass.new(ride, ~U[2024-01-01 12:00:00Z])

      assert Learn.Utils.Eq.eq?(fp1, fp2)
    end

    test "returns false for fast passes with different times" do
      {:ok, ride} = Learn.Ride.new("Haunted House", min_height_ft: 4)
      {:ok, fp1} = FastPass.new(ride, ~U[2024-01-01 12:00:00Z])
      {:ok, fp2} = FastPass.new(ride, ~U[2024-01-01 13:00:00Z])

      refute Learn.Utils.Eq.eq?(fp1, fp2)
    end
  end

  describe "not_eq?/2" do
    test "returns false for fast passes with the same time" do
      {:ok, ride} = Learn.Ride.new("Bumper Cars", min_height_ft: 2)
      {:ok, fp1} = FastPass.new(ride, ~U[2024-01-01 12:00:00Z])
      {:ok, fp2} = FastPass.new(ride, ~U[2024-01-01 12:00:00Z])

      refute Learn.Utils.Eq.not_eq?(fp1, fp2)
    end

    test "returns true for fast passes with different times" do
      {:ok, ride} = Learn.Ride.new("Swing Ride", min_height_ft: 3)
      {:ok, fp1} = FastPass.new(ride, ~U[2024-01-01 12:00:00Z])
      {:ok, fp2} = FastPass.new(ride, ~U[2024-01-01 13:00:00Z])

      assert Learn.Utils.Eq.not_eq?(fp1, fp2)
    end
  end
end
