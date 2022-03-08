class JuiceManager

  # 初期設定
  def initialize
    @juices = {coke: {price: 120, stock: 5},water: {price: 100, stock: 5},redbull: {price:200, stock: 5}}
  end

  # 引数juiceの在庫を引数store_number格納する / 戻り値：hash
  def store(juice,price,stock)
    juice = juice.to_sym
    price = price.to_i
    stock = stock.to_i
    if @juices[juice]
      @juices[juice][:stock] += stock
    else
      @juices[juice] = {price: price, stock: stock}
    end
  end

  # 引数juiceが存在するかどうか / 戻り値：true,false
  def exist?(juice)
    juice = juice.to_sym
    @juices.has_key?(juice)
  end

  # 引数juiceの在庫数 / 戻り値：integer
  def stock(juice)
    juice = juice.to_sym
    @juices[juice][:stock] if self.exist?(juice)
  end

  # 全商品の在庫確認
  def stock_all
    juices = @juices.map {|k, v| "#{k}: #{v[:stock]}本"}
    juices.join(',')
  end

  # 引数juiceの価格 / 戻り値：integer
  def price(juice)
    juice = juice.to_sym
    @juices[juice][:price] if self.exist?(juice)
  end

  # 引数juiceが買えるかどうか / 戻り値：true,false
  def purchasable?(juice,money)
    juice = juice.to_sym
    self.stock(juice) > 0 && self.price(juice) <= money if self.exist?(juice)
  end

  # 買えるドリンクのリスト / 戻り値：array 例：[:coke,:water]
  def purchasable_list(money)
    @juices.keys.select{|juice| purchasable?(juice,money)}
  end

  # 在庫を１本減らす
  def retrieve(juice)
    @juices[juice.to_sym][:stock] -= 1
  end

end

if __FILE__ == $0
  jm = JuiceManager.new
  puts jm.stock_all
end