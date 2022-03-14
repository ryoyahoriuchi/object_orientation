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
      if ["1", "2"].include?(action)
        if action == "1"
          choice
        else
          management
        end
        return
      else
        puts "1か2を選択下さい"
      end
    end
  end

  def self.choice
    while true
      puts "何をしますか？"
      puts "1:お金を投入、2:払い戻し、3:購入する"
      action = gets.chomp
      case action
      when "1"
        insert
      when "2"
        puts "#{@accountant.amount_money}円を返却します。"
        return @accountant.refund_money
      when "3"
        return purchase
      else
        puts "1～3を選択ください"
      end
    end
  end

  def self.management
    while true
      puts "何をしますか？"
      puts "1:商品追加、2:商品リスト表示、3:終了"
      action = gets.chomp.to_s
      ["1", "2", "3"].include?(action)
      if action == "1"
        addition
      elsif action == "2"
        puts @juice_manager.juices #ジュースリスト表示メソッドをここに入れる
      elsif action == "3"
        return puts "終了します。"
      else
        puts "1～3を選択ください"
      end
    end
  end

  def self.insert
    puts "投入金額を決めてください。"
    puts "対応可能硬貨： #{Cash::MONEY.join(", ")}"
    money = gets.chomp
    money = @accountant.insert_money(money) #+ "の投入がありました" #不正投入があったかどうかの分岐を書けない
    puts "#{money}は使用できません。返却します。" if money
    # if 不正投入があったとき "#{money}の不正投入がありましたので返却します。"と書きたい
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
    puts "何円に設定しますか？"
    pricing = true
    while true
      price = gets.chomp
      if price =~ /\A[1-9]\d*\z/
        price = price.to_i
        break
      else
        puts "不正な金額です。数値で入力ください"
      end
    end
    replenishment = true
    puts "何本格納しますか？"
    while replenishment
      stock = gets.chomp
      if stock =~ /\A[1-9]\d*\z/
        stock = stock.to_i
        break
      else
        puts "不正な本数です。数値で入力ください"
      end
    end
    @juice_manager.store(juice, price, stock)
    puts "#{juice}を#{price}円で#{stock}本追加しました"
  end
end
