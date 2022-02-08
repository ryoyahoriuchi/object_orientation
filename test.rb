def purchasable?(juice)
  if @juices[juice]
    @juices[juice][:stock] !=0 && @juices[juice][:price] <= @amount_money
  else
    false
  end
end
vm.purchasable?(:coke)
vm.purchasable?(:water)
vm.purchasable?("coke")
@juices[:water] -> nil
@juices[:water][:stock] -> error
@juices[:water][:name] -> error
