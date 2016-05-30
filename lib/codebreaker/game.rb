module Codebreaker
  class Game

    attr_accessor :secret_code

    def initialize
      @secret_code = ""
    end

    def start
      @secret_code = (1..4).map { rand(1..6) }*''
    end

    def check_guess(guess)
      return "++++" if guess == @secret_code
      check_number_match(*check_exact_match(@secret_code, guess))
    end   

    def check_exact_match(code, guess)
      res, res_code, res_guess = '', '', ''
      (0...code.size).each do |i|
        if code[i] == guess[i]
          res += '+'
        else
          res_code += code[i]
          res_guess += guess[i]
        end
      end
      [res, res_code, res_guess]
    end

    def check_number_match(res, code, guess)
      (0...guess.size).each do |i|
        (0...code.size).each do |j|
          if guess[i] == code[j]
            code[j] = ''
            res += '-'
            break
          end
        end
      end
      res
    end

    def get_hint()
      @secret_code[rand(0...4)]
    end

  end
end