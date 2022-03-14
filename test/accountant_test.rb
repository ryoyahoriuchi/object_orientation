require "minitest/autorun"
require_relative "../accountant.rb"
require_relative "../cash.rb"
require_relative "../juice_manager.rb"
require_relative "../vending_machine.rb"

class Accountant_Test < Minitest::Test
  def setup
    @cash = Cash.new
    @juice_manager = JuiceManager.new
    @accountant = Accountant.new(@cash, @juice_manager)
  end

  def test_add_amount_money_when_corect_money_insert
    assert_nil @accountant.insert_money(100)
    assert_equal 100, @accountant.amount_money
  end

  def test_refound_money_when_refound
    @accountant.insert_money(100)
    assert_equal 100, @accountant.refund_money
    assert_equal 0, @accountant.amount_money
  end

  def test_return_money_when_incorrect_money_insert
    assert_equal 20, @accountant.insert_money(20)
    assert_equal 0, @accountant.amount_money
  end

  def test_return_money_when_incorrect_money_insert
    assert_equal "100a", @accountant.insert_money("100a")
    assert_equal 0, @accountant.amount_money
  end

  def test_purchasable_when_enough_amount_money
    @accountant.insert_money(100)
    2.times{ @accountant.insert_money(10) }
    assert @accountant.purchasable?(:coke)
  end
  def test_purchasable_when_not_enough_amount_money
    @accountant.insert_money(100)
    refute @accountant.purchasable?(:coke)
  end
  def test_purchasable_when_not_enough_juice
    @accountant.insert_money(100)
    2.times{ @accountant.insert_money(10) }
    5.times { @juice_manager.retrieve(:coke) }
    refute @accountant.purchasable?(:coke)
  end
  def test_purchasable_when_not_such_juice
    @accountant.insert_money(100)
    2.times{ @accountant.insert_money(10) }
    refute @accountant.purchasable?(:grapejuice)
  end

  def test_purchase_when_enough_ammuont_money_and_enough_juice
    juice = :coke
    @accountant.insert_money(100)
    3.times{ @accountant.insert_money(10) }
    # 購入前
    assert_equal 130, @accountant.amount_money
    assert_equal 0, @accountant.sale_amount
    assert_equal 5, @juice_manager.stock(juice)
    # 購入後
    assert_equal 10, @accountant.purchase(juice)
    assert_equal 0, @accountant.amount_money
    assert_equal 120, @accountant.sale_amount
    assert_equal 4, @juice_manager.stock(juice)
  end

  def test_purchase_when_not_enough_ammuont_money_and_enough_juice
    juice = :coke
    @accountant.insert_money(100)
    # 購入前
    assert_equal 100, @accountant.amount_money
    assert_equal 0, @accountant.sale_amount
    assert_equal 5, @juice_manager.stock(juice)
    # 購入後
    assert_nil @accountant.purchase(juice)
    assert_equal 100, @accountant.amount_money
    assert_equal 0, @accountant.sale_amount
    assert_equal 5, @juice_manager.stock(juice)
  end

  def test_purchase_when_enough_ammuont_money_and_not_enough_juice
    juice = :coke
    @accountant.insert_money(100)
    2.times{ @accountant.insert_money(10) }
    5.times { @juice_manager.retrieve(:coke) }
    # 購入前
    assert_equal 120, @accountant.amount_money
    assert_equal 0, @accountant.sale_amount
    assert_equal 0, @juice_manager.stock(juice)
    # 購入後
    assert_nil @accountant.purchase(juice)
    assert_equal 120, @accountant.amount_money
    assert_equal 0, @accountant.sale_amount
    assert_equal 0, @juice_manager.stock(juice)
  end
end
