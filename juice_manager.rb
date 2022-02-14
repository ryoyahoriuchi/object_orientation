class JuiceManager

  # 初期設定
  def initialize
    @juices = {coke: {name: "コーラ", price: 120, stock: 5},water: {name: "水", price: 100, stock: 5},redbull: {name: "redbull", price:200, stock: 5}}
  end

  # 引数juiceの在庫を引数store_number格納する / 戻り値：hash
  def store(juice,store_number)
    @juices[juice.to_sym][:stock] += store_number
  end

  # 引数juiceの在庫数 / 戻り値：integer
  def stock(juice)
    @juices[juice.to_sym][:stock]
  end

  # 引数juiceの価格 / 戻り値：integer
  def price(juice)
    @juices[juice.to_sym][:price]
  end

  # 引数juiceが買えるかどうか / 戻り値：true,false
  def purchasable?(juice)
    juice = juice.to_sym
    if @juices[juice]
      @juices[juice][:stock] > 0 && @juices[juice][:price] <= @cash.amount_money
    else
      false
    end
  end

  # 買えるドリンクのリスト / 戻り値：array 例：[:coke,:water]
  def purchasable_list
    @juices.keys.select{|juice| purchasable?(juice)}
  end

  # 在庫を１本減らす
  def retrieve(juice)
    @juices[juice.to_sym][:stock] -= 1
  end

  # 商品があるかどうか / 戻り値：true,false
  # 商品を追加する


end