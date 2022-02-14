class JuiceManager

  # 初期設定
  def initialize
    @juices = {coke: {price: 120, stock: 5},water: {price: 100, stock: 5},redbull: {price:200, stock: 5}}
  end

  # 引数juiceの在庫を引数store_number格納する / 戻り値：hash
  def store(juice,price,stock)
    juice = juice.to_sym
    if @juices.has_key?(juice)
      @juices[juice][:stock] += stock
    else
      @juices[juice] = {price: price, stock: stock}
    end
  end

  #商品追加
  # def juice_add(juice,name,price,stock)
  #   @juices[juice.to_sym] = {name: name, price: price, stock: stock}
  # end

  # 引数juiceの在庫数 / 戻り値：integer
  def stock(juice)
    juice = juice.to_sym
    @juices[juice][:stock] if @juices[juice]
  end

  # 引数juiceの価格 / 戻り値：integer
  def price(juice)
    juice = juice.to_sym
    @juices[juice][:price] if @juices[juice]
  end

  # 引数juiceが買えるかどうか / 戻り値：true,false
  def purchasable?(juice,money)
    juice = juice.to_sym
    self.stock(juice) > 0 && self.price(juice) <= money
  end

  # 買えるドリンクのリスト / 戻り値：array 例：[:coke,:water]
  def purchasable_list(money)
    @juices.keys.select{|juice| purchasable?(juice,money)}
  end

  # 在庫を１本減らす
  def retrieve(juice)
    @juices[juice.to_sym][:stock] -= 1
  end

  # 商品があるかどうか / 戻り値：true,false
  # 商品を追加する

end

if __FILE__ == $0
  jm = JuiceManager.new
  jm.store(:coke,10)
  jm.juice_add(:orange,"オレンジ",150,10)
  p jm.price(:coke)
end