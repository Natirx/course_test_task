class AccountRepository
  private_class_method :new

  def self.account pin
    Account.new load_account_data pin
  end

  def self.load_account_data pin
    ParseData.parse_yaml_file_data['accounts'][pin.to_i]
  end

  def self.check_accounts_pin pin
    raise AtmRunTimeError, 'THERE IS NO SUCH ACCOUNT IN SYSTEM' if load_account_data(pin).nil?
  end

end