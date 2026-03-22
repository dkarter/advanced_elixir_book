defmodule Learn.Utils.Ord.UtilsTest do
  use ExUnit.Case, async: true

  alias Learn.Utils.Ord.Utils

  describe "compare/3" do
    test "returns :lt when a is less than b" do
      assert Utils.compare(1, 2) == :lt
    end

    test "returns :gt when a is greater than b" do
      assert Utils.compare(3, 2) == :gt
    end

    test "returns :eq when a is equal to b" do
      assert Utils.compare(2, 2) == :eq
    end
  end

  describe "comparator/1" do
    test "returns a function that compares two values" do
      comparator = Utils.comparator()

      assert is_function(comparator, 2)
      assert comparator.(1, 2)
      refute comparator.(3, 2)
    end
  end

  describe "to_eq/1" do
    test "returns a map with eq? and not_eq? functions" do
      eq_functions = Utils.to_eq()

      assert is_function(eq_functions.eq?, 2)
      assert is_function(eq_functions.not_eq?, 2)
    end

    test "eq? returns true for equal values" do
      eq_functions = Utils.to_eq()

      assert eq_functions.eq?.(2, 2)
    end

    test "eq? returns false for different values" do
      eq_functions = Utils.to_eq()

      refute eq_functions.eq?.(1, 2)
    end

    test "not_eq? returns true for different values" do
      eq_functions = Utils.to_eq()

      assert eq_functions.not_eq?.(1, 2)
    end

    test "not_eq? returns false for equal values" do
      eq_functions = Utils.to_eq()

      refute eq_functions.not_eq?.(2, 2)
    end
  end
end
