require_relative "./accountant.rb"
require_relative "./juice_manager.rb"
require_relative "./cash.rb"

class VendingMachine
  @cash = Cash.new
  @juice_manager = JuiceManager.new
  @accountant = Accountant.new(@cash, @juice_manager)

  def self.start
    while true
      puts "あなたは何をするか決めてください"
      puts "1:購入、2:管理業務"
      action = gets.chomp
      case action
      when "1"
        break choice
      when "2"
        break management
      else
        puts "1か2を選択下さい"
      end
    end  
  end

  def self.choice
    while true
      puts "何をしますか？"
      puts "1:お金を投入、2:払い戻し、3:購入する"
      action = gets.chomp.to_s
      case action
      when "1"
        insert
      when "2"
        puts "#{@accountant.amount_money}円を返却します。"
        return @accountant.refund_money
      when "3"
        break purchase
      else
        puts "1～3を選択ください"
      end
    end
  end

  def self.management
    while true
      puts "何をしますか？"
      puts "1:商品追加、2:商品リスト表示、3:売上表示、4:終了"
      action = gets.chomp.to_s
      case action
      when "1"
        addition
      when "2"
        juices = @juice_manager.stock_all.map {|k, v| "#{k}: #{v[:price]}円 #{v[:stock]}本"}
        puts juices.join("、")
      when "3"
        puts "売上: #{@accountant.sale_amount}円"
      when "4"
        puts "終了します。"
        break
      else
        puts "1～4を選択ください"
      end
    end
  end

  def self.insert
    puts "投入金額を決めてください。"
    puts "対応可能硬貨： #{Cash::MONEY.join(", ")}"
    money = gets.chomp
    object = @accountant.insert_money(money)
    puts "#{object}は使用できません。返却します。" if object 
  end

  def self.purchase
    puts "購入可能リストは下記の通りです。"
    puts @accountant.purchasable_list(@accountant.amount_money).join(", ")
    puts "何を購入しますか？"
    juice = gets.chomp
    if @accountant.purchasable?(juice)
      change = @accountant.purchase(juice)
      puts "#{juice}を購入しました"
      puts "おつりは#{change}円です"
    else
      puts "購入できません"
      choice
    end
  end

  def self.addition
    puts "何のジュースを追加しますか？"
    juice = gets.chomp
    unless @juice_manager.exist?(juice)
      while true
        puts "何円に設定しますか？"
        price = gets.chomp
        break if (price =~ /\A[1-9][0-9]*\z/)
        puts "不正な値です。数値で入力ください"
      end
    end
    while true
      puts "何本格納しますか?"
      stock = gets.chomp
      break if (stock =~ /\A[1-9][0-9]*\z/)
      puts "不正な値です。数値で入力ください"
    end
    @juice_manager.store(juice, price, stock)
    if @juice_manager.exist?(juice)
      price = @juice_manager.price(juice)
      puts "#{juice}を#{price}円で#{stock}本追加しました"
    else
      puts "#{juice}を#{price}円で#{stock}本追加しました"
    end
  end
end