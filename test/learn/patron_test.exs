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

  describe "eq?/2" do
    test "returns true for identical patrons" do
      {:ok, patron} = Patron.new("Eve", age_years: 28, height_ft: 5)
      {:ok, updated_patron} = Patron.change(patron, age_years: 22, height_ft: 3)
      # elixir equality will be false
      refute patron == updated_patron
      # but our eq? function should return true since they have the same id
      assert Learn.Utils.Eq.eq?(patron, updated_patron)
    end

    test "returns false for different patrons" do
      {:ok, patron1} = Patron.new("Frank", age_years: 22, height_ft: 6)
      {:ok, patron2} = Patron.new("Grace", age_years: 22, height_ft: 6)
      # elixir equality will be false
      refute patron1 == patron2
      # our eq? function should also return false since they have different ids
      refute Learn.Utils.Eq.eq?(patron1, patron2)
    end
  end

  describe "not_eq?/2" do
    test "returns false for identical patrons" do
      {:ok, patron} = Patron.new("Heidi", age_years: 30, height_ft: 5)
      {:ok, updated_patron} = Patron.change(patron, age_years: 25, height_ft: 4)
      # elixir equality will be false
      refute patron == updated_patron
      # our not_eq? function should also return false since they have the same id
      refute Learn.Utils.Eq.not_eq?(patron, updated_patron)
    end

    test "returns true for different patrons" do
      {:ok, patron1} = Patron.new("Ivan", age_years: 22, height_ft: 6)
      {:ok, patron2} = Patron.new("Judy", age_years: 22, height_ft: 6)
      # elixir equality will be false
      refute patron1 == patron2
      # our not_eq? function should return true since they have different ids
      assert Learn.Utils.Eq.not_eq?(patron1, patron2)
    end
  end
end
