module Codebreaker

  module Messages
    def devider
      puts "------------------------------------------"
    end

    def no_hints
      devider
      puts "You don't have any hints"
    end

    def welcome
      devider
      puts "||\tHi!!! This is CODEBREAKER\t||"
      devider
    end

    def you_win
      devider
      puts "You WIN !!! :)"
    end

    def you_lose
      devider
      puts "You LOSE :("
    end

    def wrong_input
      devider
      puts "Wrong input. Try again"
    end
  end

end