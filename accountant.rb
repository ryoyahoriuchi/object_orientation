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
    return money unless @cash.useful?(money)
    @cash.amount_money += money
    return
  end

  # 払い戻し操作
  #（投入金額を釣り銭として出力し、投入金額を0にする）
  def refund_money
    temp, @cash.amount_money = @cash.amount_money, 0
    temp
  end

  # 投入金額、在庫の点で、購入できるかboolean型で返す
  def purchasable?(juice)
    @juice_manager.purchasable?(juice, @cash.amount_money)
  end


  # 購入できる場合は、ジュースとお釣りを返す
  def purchase(juice)
    if self.purchasable?(juice)
      price = @juice_manager.price(juice)
      @juice_manager.retrieve(juice)
      @cash.amount_money -= price
      @cash.sale_amount += price
      self.refund_money
    end
  end

  # 購入可能なドリンクのリストを出す。
  def purchasable_list(money)
    @juice_manager.purchasable_list(money)
  end

end

# 以下はテスト用に作った仮のクラス
# class Cash
#   attr_accessor :amount_money, :sale_amount
#   MONEY = [10, 50, 100, 500, 1000].freeze

#   def initialize
#     @amount_money = 0
#     @sale_amount = 0
#   end

#   def useful?(money)
#     MONEY.include?(money)
#   end
# end


# class JuiceManager
#   attr_accessor :juices

#   def initialize
#     @juices = {coke: {price: 120, stock: 5}}
#   end

#   def purchasable?(juice, money)
#     juice = juice.to_sym
#     if @juices[juice]
#       @juices[juice][:stock] > 0 && @juices[juice][:price] <= money
#     else
#       false
#     end
#   end

#   def purchasable_list(money)
#     @juices.keys.select{|juice| purchasable?(juice, money)}
#   end

#   def store(juice, price, count)
#     if @juices[juice]
#       @juices[juice][:stock] += count
#     else
#       @juices[juice] = {price: price, stock: count}
#     end
#   end

#   def stock(juice)
#     @juices[juice][:stock] if @juices[juice]
#   end

#   def retrieve(juice)
#     juice = juice.to_sym
#     @juices[juice][:stock] -= 1 if self.stock(juice)
#   end

#   def price(juice)
#     juice = juice.to_sym
#     @juices[juice][:price] if self.stock(juice)
#   end
# end