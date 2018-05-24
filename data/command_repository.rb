require_relative "../tools/parse_data"
require_relative 'command'

class CommandRepository
  private_class_method :new

  def self.load_commands
    Command.new(parse_commands)
  end

  def self.parse_commands
    ParseData.parse_yaml_commands_data
  end

end