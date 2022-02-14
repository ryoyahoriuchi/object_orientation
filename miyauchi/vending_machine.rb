class VendingMachine
  attr_reader :amount_money, :sale_amount
  
  # お金の設定
  MONEY = [10, 50, 100, 500, 1000].freeze

  # 自販機の初期設定
  def initialize
    @amount_money = 0
    @sale_amount = 0
    @juices = {coke: {name: "コーラ", price: 120, stock: 5}}
  end

  # お金を投入する
  def insert_money(money)
    return puts "#{money}を返却します。" unless MONEY.include?(money)
    @amount_money += money
  end

  # 釣り銭
  def refund_money
    puts @amout_money
    @amout_money = 0
  end

  # 現状の自販機状況を報告
  def juice_management
    @juices.each do |key,hash|
      puts "#{hash[:name]}は#{hash[:price]}円で在庫は#{hash[:stock]}本です。"
    end
  end

  # ジュースが買えるかどうか
  def purchasable?(juice)
    juice = juice.to_sym
    if @juices[juice]
      @juices[juice][:stock] !=0 && @juices[juice][:price] <= @amount_money
    else
      false
    end
  end

  # 購入可能なドリンクリスト。戻り値：Array [:coke, :water]
  def purchasable_list
    @juices.keys.select{|juice| purchasable?(juice)}
  end

  # ジュースの在庫追加
  def store(juice, name, price, stock)
    if @juices[juice.to_sym]
      @juices[juice.to_sym][:stock] += stock
    else
      @juices[juice.to_sym] = {name: name, price: price, stock: stock}
    end
  end

  # ジュース１本を買う
  def purchase(juice)
    if self.purchasable?(juice)
      buy_juice = @juices[:"#{juice}"][:price]
      @amount_money -= buy_juice
      @sale_amount += buy_juice
      @juices[:"#{juice}"][:stock] -= 1
    end
  end
end

# 在庫数も一緒でよさそう？感覚的に使いやすそう
# クラス名は「juice」ではなく「Drink」の方がよさそう

class JuiceManager

  # 初期設定
  def initialize
    @juices = {coke: {name: "コーラ", price: 120, stock: 5},water: {name: "水", price: 100, stock: 5}}
    # @coke = {name: "コーラ", price: 120, stock: 5}
    # @water = {name: "コーラ", price: 120, stock: 5}
  end

  # 引数juiceの在庫を引数store_number格納する
  def store(juice,store_number)
    # juice = @juices.find{|k,v| v == "name:#{juice_name}"}
    @juices[juice.to_sym][:stock] += store_number
  end

  # 引数juiceの在庫数
  def stock(juice)
    @juices[juice.to_sym][:stock]
  end

  # 引数juiceの価格
  # 商品を追加する

end



if __FILE__ == $0
  juice = Juice.new
  p juice
  juice.store("coke",5)
  p juice
  p juice.stock_number("coke")
  # vm = VendingMachine.new
  # vm.juice_management
  # vm.insert_money 100
  # vm.insert_money 10
  # vm.insert_money 10
  # # vm.purchase(:coke)
  # # puts vm.amount_money
  # # puts vm.sale_amount
  # vm.juice_management
  # vm.store(:water, "水", 100, 5)
  # vm.juice_management
  # vm.store(:coke, "コーラ", 120, 5)
  # vm.juice_management
  # vm.store(:water, "水", 100, 5)
  # vm.juice_management
  # p vm.purchasable_list
  # return vm.purchasable?(:cola)
  # # -> true, false
  # return vm.purchase(:cola) # <- purchasableを使う
  # # -> true, false

# ジュースを3種類管理できるようにする。

# 在庫にレッドブル（値段:200円、名前”レッドブル”）5本を追加する。

# 在庫に水（値段:100円、名前”水”）5本を追加する。

# 投入金額、在庫の点で購入可能なドリンクのリストを取得できる。

end