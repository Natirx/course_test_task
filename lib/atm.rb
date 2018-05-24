class Atm

  attr_reader :config, :banknotes, :withdraw
  attr_accessor :customer

  def initialize prompter
    @config = ParseData.parse_yaml_file_data
    @prompter = prompter
    @customer
    @withdraw = BanknotesRepository.banknote(prompter)
  end

  def init
    account_number = @prompter.prompt('Please Enter Your Account Number:')
    AccountRepository.check_accounts_pin account_number
    raise AtmRunTimeError, 'The digits must be 4 characters long' unless account_number.length.eql? 4
    @customer = AccountRepository.account account_number
    login_error_count = 0
    begin
      customer.password_valid?(@prompter.prompt('Enter Your Password:'))
    rescue InvalidPasswordError => e
      raise LoginThrottleError, e.message + '. Atm would exit now' if login_error_count >= 3
      login_error_count += 1
      retry
    end
    puts "Hello, #{customer.get_account_name}!", ' '
    init_commands
  end

  def init_commands
    CommandRepository.load_commands.return_command
    process_command(@prompter.prompt(''))
  end


  def process_command(command)
    case command.to_i
      when 1
        puts "Your Current Balance is  #{customer.get_account_balance}", ''
      when 2
        puts ''
        customer.change_account_balance withdraw.withdraw_operation customer.get_account_balance
      when 3
        puts 'Unauthenticating you via our secure sever', 'You have been successfully logged out'
        exit
      else
        puts '', 'Unknown Command', ''
    end
    init_commands
  end

end
