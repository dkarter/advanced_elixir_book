defmodule Learn.Utils.OrdTest do
  use ExUnit.Case, async: true

  alias Learn.Utils.Ord

  describe "Ord protocol for Any" do
    test "lt?/2 returns true when first value is less than second" do
      assert Ord.lt?(1, 2)
      assert Ord.lt?(-5, 0)
    end

    test "le?/2 returns true when first value is less than or equal to second" do
      assert Ord.le?(1, 2)
      assert Ord.le?(2, 2)
      assert Ord.le?(-5, 0)
    end

    test "gt?/2 returns true when first value is greater than second" do
      assert Ord.gt?(2, 1)
      assert Ord.gt?(0, -5)
    end

    test "ge?/2 returns true when first value is greater than or equal to second" do
      assert Ord.ge?(2, 1)
      assert Ord.ge?(2, 2)
      assert Ord.ge?(0, -5)
    end
  end
end
