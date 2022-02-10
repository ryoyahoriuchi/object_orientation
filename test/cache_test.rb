require 'minitest/autorun'
require_relative '../cache'

class CacheTest < Minitest::Test
    def test_cache
        cache = Cache.new
        assert_equal 0, cache.amount_money
        assert_equal 0, cache.sale_amount
        cache.amount_money += 100
        cache.sale_amount += 1000
        assert_equal 100, cache.amount_money
        assert_equal 1000, cache.sale_amount
    end
    def test_money
        cache = Cache.new
        assert_equal 10, cache.money[0]
        assert_equal 50, cache.money[1]
        assert_equal 100, cache.money[2]
        assert_equal 500, cache.money[3]
        assert_equal 1000, cache.money[4]
    end
end
