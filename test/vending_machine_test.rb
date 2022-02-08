require "minitest/autorun"
require_relative "../vending_machine.rb"

class VendingMachineTest < Minitest::Test
  def setup
    @vm = VendingMachine.new
  end

  def test_true_when_corect_money_insert
    assert_equal 0, @vm.amount_money
    @vm.insert_money 100
    assert_equal 100, @vm.amount_money
  end

  def test_false_when_incorect_money_insert
    assert_equal 0, @vm.amount_money
    @vm.insert_money 20
    assert_equal 0, @vm.amount_money
  end

  def test_true_when_existence_store

  end

  def test_true_when_nil
end