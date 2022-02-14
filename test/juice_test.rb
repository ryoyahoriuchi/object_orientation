class Juice
attr_accessor :name, :price
 def name
    return "#{self.name}"
 end

 def price
   return "#{self.price}円"
 end

 def info
    return "#{self.name}は#{self.price}です"
 end

juice1 = Juice.new
juice1.name = "コーラ"
juice1.price = 120

puts juice1.info

end