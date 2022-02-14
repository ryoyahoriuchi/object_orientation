class Cach
    MONEY = [10, 50, 100, 500, 1000].freeze
    attr_accessor :amount_money, :sale_amount

    def initialize
        @amount_money = 0
        @sale_amount = 0
    end

    def useful?(money)
        MONEY.include?(money)
    end
end