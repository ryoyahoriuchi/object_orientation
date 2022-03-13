class Accountant

  # cashクラスとstockクラスを初期値にセット
  def initialize(cash, juice_manager)
    @cash = cash
    @juice_manager = juice_manager
  end

  # 投入金額の総計取得用
  def amount_money
    @cash.amount_money
  end

  # 売上金額の取得用
  def sale_amount
    @cash.sale_amount
  end

  # 投入操作
  # 使用できるお金であれ投入金額に加算
  # 想定外のものは投入金額に加算せず、returnする
  def insert_money(money)
    if money.to_s =~ /\A[1-9]\d*\z/ && @cash.useful?(money.to_i)
      @cash.amount_money += money.to_i
      return
    else
      return money
    end
  end

  # 払い戻し操作
  #（投入金額を釣り銭として出力し、投入金額を0にする）
  def refund_money
    temp, @cash.amount_money = @cash.amount_money, 0
    temp
  end

  # 投入金額、在庫の点で、購入できるかboolean型で返す
  def purchasable?(juice)
    @juice_manager.exist?(juice) &&
@juice_manager.price(juice) <= @cash.amount_money && @juice_manager.stock(juice) > 0
  end

  # 購入できる場合は、ジュースとお釣りを返す
  def purchase(juice)
    if purchasable?(juice)
      price = @juice_manager.price(juice)
      @juice_manager.retrieve(juice)
      @cash.amount_money -= price
      @cash.sale_amount += price
      refund_money
    end
  end

  # 購入可能なドリンクをArrayで返す。
  def purchasable_list(money)
    stock_list = @juice_manager.instance_variable_get(:@juices)
    stock_list.keys.select{|juice| purchasable?(juice)}
  end

end
