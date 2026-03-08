defmodule Learn.PatronTest do
  use ExUnit.Case, async: true

  alias Learn.Patron

  describe "new/2" do
    test "creates a new patron with valid input" do
      assert {:ok, %Patron{name: "Alice", age_years: 30, height_ft: 5}} =
               Patron.new("Alice", age_years: 30, height_ft: 5)
    end

    test "returns error for invalid input" do
      assert {:error, _} = Patron.new("", age_years: -1, height_ft: 0)
    end
  end

  describe "change/2" do
    test "successfully changes valid fields" do
      {:ok, patron} = Patron.new("Bob", age_years: 25, height_ft: 6)
      assert {:ok, %Patron{age_years: 26}} = Patron.change(patron, age_years: 26)
    end

    test "does not allow changing id" do
      {:ok, patron} = Patron.new("Charlie", age_years: 40, height_ft: 5)
      assert {:ok, %Patron{id: id}} = Patron.change(patron, id: 999)
      assert id != 999
    end

    test "returns error for invalid changes" do
      {:ok, patron} = Patron.new("Dave", age_years: 35, height_ft: 5)
      assert {:error, _} = Patron.change(patron, age_years: -5)
    end
  end
end
