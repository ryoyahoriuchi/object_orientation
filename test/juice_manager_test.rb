require "minitest/autorun"
require_relative "../juice_manager"

class JuiceManagerTest < Minitest::Test
  def setup
    @jm = JuiceManager.new
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

  def test_exist_when_exist
    assert @jm.exist?(:coke)
  end
  def test_exist_when_not_exist
    refute @jm.exist?("orange")
  end

  # stockメソッドのテストです
  def test_stock_when_juice_exists
    assert_equal 5, @jm.stock(:coke)
  end
  def test_stock_when_juice_does_not_exist
    # 戻り値がnilとなるが、0の方が良いのか？
    assert_equal 0, @jm.stock("orange")
  end

  def test_stock_all
    assert_equal({:coke=>{:price=>120, :stock=>5}, :water=>{:price=>100, :stock=>5}, :redbull=>{:price=>200, :stock=>5}}, @jm.stock_all)
  end

  # priceメソッドのテスト
  def test_price_when_juice_exists
    assert_equal 120, @jm.price(:coke)
  end
  def test_price_when_juice_not_exists
    assert_nil @jm.price(:orange)
  end

  def test_retrieve_when_juice_exists
    assert_equal 4, @jm.retrieve(:coke)
  end
  def test_retrieve_when_juice_does_not_exist
    assert_nil @jm.retrieve("orange")
  end
  def test_retrieve_when_not_enough_juice
    5.times{@jm.retrieve(:coke)}
    assert_nil @jm.retrieve(:coke)
  end
end
