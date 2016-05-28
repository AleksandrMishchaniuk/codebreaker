module Codebreaker
  class Manager
    ATTEMPTS = 5
    HINTS = 1
    
    def initialize
      @attempt_count = nil
      @hint_count = nil
      @game = nil
    end

    def start
      begin
        flag = false
        text = ask_action
        case text
          when 'q'
            quit
          when 'r'
            print_results
            start_game?
          when 'g'
            start_game
          else
            flag = true
            wrong_input
        end
      end while flag
    end

    def start_game?
      begin
        flag = false
        text = ask_action
        case text
          when 'q'
            quit
          when 'g'
            start_game
          else
            flag = true
            wrong_input
        end
      end while flag
    end

    def start_game
      @attempts_count = ATTEMPTS
      @hints_count = HINTS
      @game = Game.new
      while @attempts_count > 0
        if make_attempt
          you_win
          break
        end
      end
      you_lose if @attempts_count <= 0 
      save_game?
    end

    def make_attempt; end

    def you_win; end

    def you_lose; end

    def save_game?; end

    def quit; end

  end
end