defmodule Learn.RideTest do
  use ExUnit.Case, async: true

  alias Learn.Ride

  describe "change/2" do
    test "updates a ride with valid changes" do
      {:ok, ride} = Ride.new("Ferris Wheel", min_height_ft: 3)

      assert {:ok, %Ride{name: "Big Wheel", min_height_ft: 4}} =
               Ride.change(ride, name: "Big Wheel", min_height_ft: 4)
    end

    test "ignores id updates" do
      {:ok, ride} = Ride.new("Carousel", min_height_ft: 1)

      assert {:ok, %Ride{id: id}} = Ride.change(ride, id: 999_999)
      assert id == ride.id
    end

    test "returns error for invalid changes" do
      {:ok, ride} = Ride.new("Drop Tower", min_height_ft: 4)

      assert {:error,
              [%Zoi.Error{path: [:name], message: "too small: must have at least 1 character(s)"}]} =
               Ride.change(ride, name: "")
    end
  end
end
