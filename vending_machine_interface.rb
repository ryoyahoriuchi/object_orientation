require_relative "accountant"
require_relative "cash"
require_relative "juice_manager"

class VendingMachine
  attr_reader :accountant, :juice_manager
  def initialize
    cash = Cash.new
    @juice_manager = JuiceManager.new
    @accountant = Accountant.new(cash, @juice_manager)
  end

  def start
    role = choose(:role)
    if role == 1 # 購入者
      purchase_step
    elsif role == 2 # 管理者

    end
  end

  private

  # 引数actionに応じて、メッセージと選択リスト、そしてリスト出力時にNo.を付けるかどうか判定するフラグの３つの要素の配列を返す
  def get_message(action)
    no_number = false
    case action
    when :role
      list = %w[購入者 管理者]
      message = "該当する数字を入力して下さい。"
    when :action
      list = %w[お金を投入 払い戻し 購入する]
      message = "何をしますか?下記より数字を選択して下さい。"
    when :juice
      list = @accountant.purchasable_list(@accountant.amount_money).map(&:to_s)
      message = "購入可能ジュースは下記の通りです。\n数字を選択して下さい。"
    when :insert
      list = Cash::MONEY
      message = "使用できるお金は以下の通りです。\nお金を入力して下さい"
      no_number = true
    end
    [list, message, no_number]
  end

  def get_input(list, message, no_number)
    puts message
    list_message =
      if no_number
        list.join(", ")
      else
        list.map.with_index{|select, i| "#{i+1}: #{select}"}.join(", ")
      end
    puts list_message
    gets.chomp.tr("１-１０００", "1-1000")
  end

  # 引数actinによって、選択するリスト
  def choose(action)
    list, message, no_number = *get_message(action)
    if Array(list).any?
      num = get_input(list, message, no_number)
      list_range =
        if no_number
          list.map(&:to_s)
        else
          (1..list.length).to_a.map(&:to_s)
        end
      while num
        if list_range.include?(num)
          return num.to_i
        else
          num = get_input(list, message, no_number)
        end
      end
    end
  end

  def purchase_step
    action = choose(:action)
    while true
      case action
      when 1
        money = choose(:insert)
        money = @accountant.insert_money(money)
        if money
          puts "#{money}は使用できるお金ではありません。"
        else
          puts "投入金額の合計は¥#{@accountant.amount_money}です"
        end
        action = choose(:action)
      when 2
        puts "払い戻し金額は¥#{@accountant.refund_money}"
        puts "ご利用ありがとうございました。"
        break
      when 3
        list = @accountant.purchasable_list(@accountant.amount_money)
        if list.any?
          juice_num = choose(:juice)
          juice = list[juice_num - 1]
          change = @accountant.purchase(juice)
          puts "#{juice}をご購入されました。"
          puts "お釣りは¥#{change}です。"
          puts "ありがとうございました。"
          break
        else
          puts "購入できるジュースがありません。"
          action = choose(:action)
        end
      end
    end
  end

end

# if __FILE__ == $0
#   vm = VendingMachine.new
#   puts vm.start
# end
