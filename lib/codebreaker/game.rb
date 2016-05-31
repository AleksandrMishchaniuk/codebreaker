module Codebreaker
  class Game

    attr_accessor :secret_code

    def initialize
      @secret_code = ""
    end

    def start
      @secret_code = (1..4).map { rand(1..6) }.join
    end

    def check_guess(guess)
      return "++++" if guess == @secret_code
      g_c = guess.split(//).zip(@secret_code.split(//)).delete_if{ |i| i[0]==i[1] }.transpose
      g_c[0].each do |g| 
        g_c[1].delete_at(g_c[1].find_index(g)) if g_c[1].include? g
      end
      '+' * (@secret_code.size - g_c[0].size) + '-' * (g_c[0].size - g_c[1].size)
    end   

    def get_hint()
      @secret_code[rand(0...4)]
    end

  end
end