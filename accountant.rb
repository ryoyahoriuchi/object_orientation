class Accountant

  # cacheクラスとstockクラスを初期値にセット
  def initialize(cache, stock)
    @cache = cache
    @stock = stock
    @juices = stock.juices
  end

  # 投入金額の総計取得用
  def amount_money
    @cache.amount_money
  end

  # 売上金額の取得用
  def sale_amount
    @cache.sale_amount
  end

  # 投入操作
  # 使用できるお金であれ投入金額に加算
  # 想定外のものは投入金額に加算せず、returnする
  def insert_money(money)
    return money unless Cache::MONEY.include?(money)
    @cache.amount_money += money
    return
  end

  # 払い戻し操作
  #（投入金額を釣り銭として出力し、投入金額を0にする）
  def refund_money
    temp, @cache.amount_money = @cache.amount_money, 0
    temp
  end

  # 投入金額、在庫の点で、購入できるかboolean型で返す
  def purchasable?(juice)
    juice = juice.to_sym
    if @juices[juice]
      @juices[juice][:stock] > 0 && @juices[juice][:price] <= @cache.amount_money
    else
      false
    end
  end


  # 購入できる場合は、ジュースとお釣りを返す
  def purchase(juice)
    if self.purchasable?(juice)
      juice = juice.to_sym
      price = @juices[juice][:price]
      @cache.amount_money -= price
      @cache.sale_amount += price
      # stockにretrieveメソッドを作るのはどうだろう。
      # retrieve(juice)で値段が取得でき、在庫が１つ減る。もしなければnilを返す
      @juices[juice][:stock] -= 1

      # お釣りをreturnする
      self.refund_money
    end
  end

  # 購入可能なドリンクのリストを出す。戻り値：Array [:coke, :water]
  # これはstockのメソッドとして作った方が良い引数にamonut_moneyを入れる
  def purchasable_list
    @juices.keys.select{|juice| purchasable?(juice)}
  end
end

# 以下はテスト用に作った仮のクラス
class Cache
  attr_accessor :amount_money, :sale_amount
  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @amount_money = 0
    @sale_amount = 0
  end
end


class Stock
  attr_accessor :juices

  def initialize
    @juices = {coke: {name: "コーラ", price: 120, stock: 5}}
  end
end