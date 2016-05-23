module Codebreaker
  class Manager
    
    def initialize
      @msg_start = 'Hi! I am Codebreaker-game. Introduce yourself: '
      @count_attempts = 5
      @count_hints = 1
      @game = nil
      @user_name = ''
    end

    def init
      print @msg_start
      @user_name = ask_name
      start_game
    end

    def start_game
      @game = Game.new
    end

    def ask_name
      gets
    end

  end
end