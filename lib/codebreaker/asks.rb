module Codebreaker

  module Asks
    
    def ask_action
      devider
      puts "What would you like to do?"
      puts "q - quit; r - see results table; g - start new game"
      gets.chomp
    end

    def ask_start_game
      devider
      puts "Would you like to start new game?"
      puts "q - quit; g - start new game"
      gets.chomp
    end

    def ask_guess
      devider
      attempts = self.instance_variable_get(:@attempts_count)
      hints = self.instance_variable_get(:@hints_count)
      puts "Type your guess. It sould be four numbers like 1234"
      puts "q - quit; h - get hint"
      puts "You have #{attempts} attempts and #{hints} hints"
      gets.chomp
    end

    def ask_save
      devider
      puts "Would you like to save your game?"
      puts "q - quit; n - no; y - yes"
      gets.chomp
    end

    def ask_user_name
      devider
      puts "Please type your name"
      puts "q - quit"
      gets.chomp
    end
  end

end