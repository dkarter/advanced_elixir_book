defmodule Learn.Utils.ListTest do
  use ExUnit.Case, async: true

  alias Learn.Utils.List

  describe "sort/2" do
    test "sorts a list of integers in ascending order" do
      assert List.sort([3, 1, 2]) == [1, 2, 3]
    end

    test "sorts a list of strings in alphabetical order" do
      assert List.sort(["banana", "apple", "cherry"]) == ["apple", "banana", "cherry"]
    end
  end

  describe "uniq/2" do
    test "removes duplicate integers from a list" do
      eq_functions = %{eq?: fn a, b -> a == b end}
      assert List.uniq([1, 2, 2, 3], eq_functions) == [1, 2, 3]
    end

    test "removes duplicate strings from a list" do
      eq_functions = %{eq?: fn a, b -> a == b end}
      assert List.uniq(["apple", "banana", "apple"], eq_functions) == ["apple", "banana"]
    end
  end

  describe "strict_sort/2" do
    test "sorts a list of integers and removes duplicates" do
      assert List.strict_sort([3, 1, 2, 2]) == [1, 2, 3]
    end

    test "sorts a list of strings and removes duplicates" do
      assert List.strict_sort(["banana", "apple", "cherry", "apple"]) == [
               "apple",
               "banana",
               "cherry"
             ]
    end
  end
end
