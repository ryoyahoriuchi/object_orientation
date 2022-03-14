class JuiceManager
  # 初期設定
  def initialize
    @juices = {coke: {price: 120, stock: 5}, water: {price: 100, stock: 5}, redbull: {price:200, stock: 5}}
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
    @juices.dig(juice, :stock) || 0
  end

  # 全商品の在庫確認 / 戻り値：Hash
  def stock_all
    @juices
  end

  # 引数juiceの価格 / 戻り値：integer or nil
  def price(juice)
    juice = juice.to_sym
    @juices[juice][:price] if self.exist?(juice)
  end

  # 在庫を１本減らす / 戻り値：integer or nil
  def retrieve(juice)
    juice = juice.to_sym
    @juices[juice][:stock] -= 1 if stock(juice)&.> 0
  end
end
