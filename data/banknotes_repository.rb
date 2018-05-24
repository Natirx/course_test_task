class BanknotesRepository
  private_class_method :new

  def self.banknote prompter
    Banknotes.new(load_banknotes, prompter)
  end

  def self.load_banknotes
    ParseData.parse_yaml_file_data['banknotes']
  end

end