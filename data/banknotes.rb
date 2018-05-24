class Banknotes

  attr_accessor :banknotes, :available_balance

  def initialize(banknotes, prompter)
    @banknotes = banknotes
    @prompter = prompter
  end

  def check(input_amount, hash, account_balance)
    if input_amount > 10000
      raise InvalidWithdrawError, 'ERROR: INSUFFICIENT FUNDS!! PLEASE ENTER A DIFFERENT AMOUNT:'
    end

    if hash.values.all? {|x| x.eql? 0}
      raise NoMoneyLeft, 'NO MONEY LEFT IN ATM, PLS GOME AGAIN LATER'
    end

    if input_amount > account_balance
      raise InvalidWithdrawError, "THE MAXIMUM AMOUNT AVAILABLE TO WITHDRAW FROM YOU ACCOUNT is #{account_balance}"
    end

    if input_amount > available_amount_to_withdraw
      raise InvalidWithdrawError, "THE MAXIMUM AMOUNT AVAILABLE IN THIS ATM IS #{available_amount_to_withdraw}. PLEASE ENTER A DIFFERENT AMOUNT:"
    end
  end

  def check_amount(input_amount)
    raise InvalidWithdrawError, 'AMOUNT YOU REQUESTED CANNOT BE COMPOSED FROM BILLS AVAILABLE IN THIS ATM. PLEASE ENTER A DIFFERENT AMOUNT:' if input_amount != 0
  end

  def available_amount_to_withdraw
    banknotes.sum {|key, value| key * value}
  end

  def withdraw (input_amount, account_balance)
    check input_amount, banknotes, account_balance
    hash = banknotes.clone
    hash.each do |key, value|
      if value != 0
        count = (input_amount / key).floor
        if value >= count
          input_amount -= (key * count)
          hash[key] -= count
        else
          input_amount -= (key * value)
          hash[key] -= value
        end
      end
    end
    check_amount input_amount
    self.banknotes = hash
  end

  def input_value
    puts 'Enter Amount You Wish to Withdraw'
    value = STDIN.gets.chomp
    if value !~ /\A\d+\z/
      raise ArgumentError, 'Only numbers alowed, try again'
    else
      value
    end
  end

  def change_balance(available_balance, input_amount)
    available_balance - input_amount
  end

  def withdraw_operation(balance)
    begin
      input_amount = input_value.to_i
      withdraw input_amount, balance
      change_balance balance, input_amount
    rescue InvalidWithdrawError, NoMoneyLeft, ArgumentError => error
      puts error.message
      exit if error.class == NoMoneyLeft
      retry
    end
  end
end
