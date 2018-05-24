class Command
  attr_reader :commands

  def initialize commands
    @commands = commands
  end

  def return_command
    commands.each {|key, value| puts "#{key}. #{value}."}
  end

end