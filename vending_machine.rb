require_relative "./accountant"
require_relative "./juice_manager"
require_relative "./cash"

class VendingMachine
  @cash = Cash.new
  @juice_manager = JuiceManager.new
  @accountant = Accountant.new(@cash, @juice_manager)

  class << self

    def start
      while true
        puts "あなたは何をするか決めてください"
        puts "1:購入、2:管理業務"
        action = gets.chomp.tr("０-９", "0-9")
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

    private

    def choice
      while true
        puts "何をしますか？1～4を選択ください"
        puts "1:お金を投入、2:払い戻し、3:購入する、4:商品一覧"
        action = gets.chomp.tr("０-９", "0-9")
        case action
        when "1"
          insert
        when "2"
          puts "#{@accountant.amount_money}円を返却します。"
          return @accountant.refund_money
        when "3"
          break purchase
        when "4"
          index
        else
          puts "1～4を選択ください"
        end
      end
    end

    def management
      while true
        puts "何をしますか？1～4を選択ください"
        puts "1:商品追加、2:商品リスト表示、3:売上表示、4:終了"
        action = gets.chomp.tr("０-９", "0-9")
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

    def insert
      puts "投入金額を決めてください。"
      puts "対応可能硬貨： #{Cash::MONEY.join(", ")}"
      money = gets.chomp.tr("０-９", "0-9")
      object = @accountant.insert_money(money)
      puts "#{object}は使用できません。返却します。" if object
    end

    def purchase
      juices = @accountant.purchasable_list.map {|k, v| "#{k}: #{v}円"}
      if !juices.empty?
        puts "購入可能リストは下記の通りです。"
        puts juices.join("、")
        puts "何を購入しますか？ジュース名を入力してください"
        juice = gets.chomp.tr("０-９ａ-ｚＡ-Ｚ", "0-9a-zA-Z")
        if @accountant.purchasable?(juice)
          change = @accountant.purchase(juice)
          puts "#{juice}を購入しました"
          puts "おつりは#{change}円です"
        else
          puts "購入できません"
          choice
        end
      else
        puts "購入できません"
        choice
      end
    end

    def addition
      puts "何のジュースを追加しますか？"
      juice = gets.chomp.tr("０-９ａ-ｚＡ-Ｚ", "0-9a-zA-Z")

      get_value = ->(message){
        while true
          puts message
          value = gets.chomp.tr("０-９", "0-9")
          break if value =~ /\A[1-9][0-9]*\z/
          puts "不正な値です。数値で入力して下さい"
        end
        value
      }

      if @juice_manager.exist?(juice)
        price = @juice_manager.price(juice)
      else
        price = get_value.call("何円に設定しますか？")
      end
      stock = get_value.call("何本格納しますか？")
      @juice_manager.store(juice, price, stock)
      puts "#{juice}を#{price}円で#{stock}本追加し、在庫は#{@juice_manager.stock(juice)}本になりました"
    end

    def index
      juices = @juice_manager.stock_all.map {|k, v| "#{k}: #{v[:price]}円"}
      puts "商品一覧"
      puts list = juices.join("、")
      puts  "-" * list.size
    end
  end
end
