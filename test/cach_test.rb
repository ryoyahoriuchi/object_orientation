require 'minitest/autorun'
require_relative '../cach'

class CachTest < Minitest::Test
    def test_cach
        cach = Cach.new
        assert_equal 0, cach.amount_money
        assert_equal 0, cach.sale_amount
        cach.amount_money += 100
        cach.sale_amount += 1000
        assert_equal 100, cach.amount_money
        assert_equal 1000, cach.sale_amount
    end
    
    def test_money
        assert_equal 10, Cach::MONEY[0]
        assert_equal 50, Cach::MONEY[1]
        assert_equal 100, Cach::MONEY[2]
        assert_equal 500, Cach::MONEY[3]
        assert_equal 1000, Cach::MONEY[4]
    end

    def test_true_useful?
        cach = Cach.new
        assert cach.useful?(10)
        assert cach.useful?(50)
        assert cach.useful?(100)
        assert cach.useful?(500)
        assert cach.useful?(1000)
    end

    def test_false_useful?
        cach = Cach.new
        refute cach.useful?(0)
        refute cach.useful?(20)
    end
end
