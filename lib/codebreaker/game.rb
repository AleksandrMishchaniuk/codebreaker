module Codebreaker
  class Game
    def initialize
      @secret_code = ""
    end

    def start
      num = Random.new
      (1..4).each do
        @secret_code += num.rand(1..6).to_s
      end
    end

    def guess_processing(guess)
      check_number_match(*check_exact_match(@secret_code, guess))
    end

    def check_exact_match(code, guess)
      res_code = ''
      res_guess = ''
      (0...code.size).each do |i|
        if code[i] == guess[i]
          res_code += '+'
          res_guess += '+'
        else
          res_code += code[i]
          res_guess += guess[i]
        end
      end
      [res_code, res_guess]
    end

    def check_number_match(code, guess)
      res = ''
      (0...guess.size).each do |i|
        if guess[i] == '+'
          res += '+'
          next
        end
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

  end
end