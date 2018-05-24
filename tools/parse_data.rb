module ParseData

  def self.parse_yaml_file_data
    YAML.load_file(ARGV.first || 'config.yml')
  rescue ArgumentError => e
    puts e.message
  end

  def self.parse_yaml_commands_data
    YAML.load_file('commands.yml')
  rescue ArgumentError => e
    puts e.message
  end

end