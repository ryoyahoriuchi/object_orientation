class Interface
    def choice
        puts "数字を入力してください。"
        puts "0:購入者, 1:業者"
       
        input_choice = gets.chomp

        while true
            if input_choice == "0" || input_choice== "1"
                return input_choice.to_i
            else
                puts "数字を入力してください。"
                puts "0:購入者, 1:業者"
                input_choice = gets.chomp
            end
        end
    end
end