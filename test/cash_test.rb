require 'minitest/autorun'
require_relative '../cash'

class CashTest < Minitest::Test
    def test_cash
        cash = Cash.new
        assert_equal 0, cash.amount_money
        assert_equal 0, cash.sale_amount
        cash.amount_money += 100
        cash.sale_amount += 1000
        assert_equal 100, cash.amount_money
        assert_equal 1000, cash.sale_amount
    end
    
    def test_money
        assert_equal 10, Cash::MONEY[0]
        assert_equal 50, Cash::MONEY[1]
        assert_equal 100, Cash::MONEY[2]
        assert_equal 500, Cash::MONEY[3]
        assert_equal 1000, Cash::MONEY[4]
    end

    def test_true_useful?
        cash = Cash.new
        assert cash.useful?(10)
        assert cash.useful?(50)
        assert cash.useful?(100)
        assert cash.useful?(500)
        assert cash.useful?(1000)
    end

    def test_false_useful?
        cash = Cash.new
        refute cash.useful?(0)
        refute cash.useful?(20)
    end
end
