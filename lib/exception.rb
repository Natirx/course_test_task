AtmRunTimeError = Class.new(RuntimeError)

BalanceOverflowError = Class.new(ArgumentError)

class FraudError < AtmRunTimeError
end

class UnknownCardError < FraudError
end

class InvalidPasswordError < FraudError
end

class InvalidWithdrawError < FraudError
end

class NoMoneyLeft < FraudError
end

LoginThrottleError = Class.new(RuntimeError)