require_relative "accountant"
require_relative "cash"
require_relative "juice_manager"

# VendingMachineでaccountant, juice_managerと同名のメソッドが使えるようにしています。実際には、メソッドから、大元のメソッドを呼び出しているだけです。
class VendingMachine
  def initialize
    @juice_manager = JuiceManager.new
    cash = Cash.new
    @accountant = Accountant.new(cash, @juice_manager)

    accountant_method = @accountant.public_methods(false)
    juice_manager_method = @juice_manager.public_methods(false) - accountant_method

    # accountant, juice_managerのメソッドを取り込み
    accountant_method.each{|method| VendingMachine.define_vm_method(@accountant, method)}
    juice_manager_method.each{|method| VendingMachine.define_vm_method(@juice_manager, method)}
  end

  # VendingMachineのメソッドを作成するメソッド
  def self.define_vm_method(object, method)
    define_method(method) do |*args|
      object.send method, *args
    end
  end
end
