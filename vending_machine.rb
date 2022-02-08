class VendingMachine
  attr_reader :amount_money, :sale_amount
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @insert_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @amount_money = 0
    @sale_amount = 0
    @juices = {coke: {name: "コーラ", price: 120, stock: 5}}
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def insert_money(money)
    # puts "#{money}を投入"
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return puts "#{money}を返却します。" unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @amount_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def refund_money
    # 返すお金の金額を表示する
    puts @amout_money
    # 自動販売機に入っているお金を0円に戻す
    @amout_money = 0
  end

  def juice_management
    # (0...@juices.length).each do |i|
    #     puts "#{juices.keys[i]}は#{juices.values[i][:price]}円で在庫は#{juice.values[i][:stock]}本です。"
    # end
    @juices.each do |key,hash|
      puts "#{hash[:name]}は#{hash[:price]}円で在庫は#{hash[:stock]}本です。"
    end

  end

  def purchasable?(juice)
    juice = juice.to_sym
    if @juices[juice]
      @juices[juice][:stock] !=0 && @juices[juice][:price] <= @amount_money
    else
      false
    end
  end

  def purchasable_list
    #購入可能なドリンクのリストを出す。戻り値：Array [:coke, :water]
    @juices.keys.select{|juice| purchasable?(juice)}
  end

  def store(juice, name, price, stock)
    # @juicesに追加される　戻り値なし
    if @juices[juice.to_sym]
      @juices[juice.to_sym][:stock] += stock
    else
      @juices[juice.to_sym] = {name: name, price: price, stock: stock}
    end
  end

  def purchase(juice)
    if self.purchasable?(juice)
      buy_juice = @juices[:"#{juice}"][:price]
      @amount_money -= buy_juice
      @sale_amount += buy_juice
      @juices[:"#{juice}"][:stock] -= 1
    end
  end
end

if __FILE__ == $0
  vm = VendingMachine.new
  # vm.juice_management
  vm.insert_money 100
  vm.insert_money 10
  vm.insert_money 10
  # vm.purchase(:coke)
  # puts vm.amount_money
  # puts vm.sale_amount
  vm.juice_management
  vm.store(:water, "水", 100, 5)
  vm.juice_management
  vm.store(:coke, "コーラ", 120, 5)
  vm.juice_management
  vm.store(:water, "水", 100, 5)
  vm.juice_management
  p vm.purchasable_list
  # return vm.purchasable?(:cola)
  # # -> true, false
  # return vm.purchase(:cola) # <- purchasableを使う
  # # -> true, false

# ジュースを3種類管理できるようにする。

# 在庫にレッドブル（値段:200円、名前”レッドブル”）5本を追加する。

# 在庫に水（値段:100円、名前”水”）5本を追加する。

# 投入金額、在庫の点で購入可能なドリンクのリストを取得できる。

end