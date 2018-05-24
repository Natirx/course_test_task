class Account
  attr_reader :account_details
  def initialize account_details
    @account_details = account_details
  end

  def get_account_balance
    account_details['balance']
  end

  def get_account_name
    account_details['name']
  end

  def get_account_password
    account_details['password']
  end

  def change_account_balance amount
    account_details['balance'] = amount
  end

  def password_valid?(password)
    raise InvalidPasswordError, 'Please input the right password' unless get_account_password == password
  end

end