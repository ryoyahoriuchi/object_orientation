require "minitest/autorun"
require_relative "../juice_manager"

class JuiceManagerTest < Minitest::Test
  def setup
    @jm = JuiceManager.new
  end

  # stockメソッドのテストです
  def test_stock_when_juice_exists
    assert_equal 5, @jm.stock(:coke)
  end
  def test_stock_when_juice_does_not_exist
    # 戻り値がnilとなるが、0の方が良いのか？
    assert_nil @jm.stock("orange")
  end

  # storeメソッドのテストstockメソッドを利用している
  def test_store_when_juice_exists
    @jm.store(:coke, 120, 5)
    assert_equal 10, @jm.stock(:coke)
  end
  def test_store_when_juice_does_not_exist
    @jm.store("orange", 110, 1)
    assert_equal 1, @jm.stock(:orange)
  end

  # priceメソッドのテスト
  def test_price_when_juice_exists
    assert_equal 120, @jm.price(:coke)
  end
  def test_price_when_juice_not_exists
    assert_nil @jm.price(:orange)
  end

  # purchasable?メソッドのテスト, 戻り値はboolean型
  def test_purchasable_when_juice_exists_and_enough_money
    assert @jm.purchasable?(:coke, 130)
  end
  def test_purchasable_when_juice_exists_and_insufficient_money
    refute @jm.purchasable?(:coke, 100)
  end
  def test_purchasable_when_juice_exists_and_insufficient_stock
    @jm.store(:coke, 120, -5)
    assert_equal 0, @jm.stock(:coke)
    refute @jm.purchasable?(:coke, 130)
  end
  def test_purchasable_when_juice_does_not_exist_and_enough_money
    # これがエラーになる
    refute @jm.purchasable?(:orange, 1000)
  end

  # purchasable_listのテスト
  def test_purchasable_list_when_enough_money
    assert_equal %i[ coke water ], @jm.purchasable_list(120).sort
  end
  def test_purchasable_list_when_insufficient_money
    assert_empty @jm.purchasable_list(90)
  end
end