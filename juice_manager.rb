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