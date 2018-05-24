class Prompter

  def prompt(question)
    puts question
    STDIN.gets.chomp
  end

end