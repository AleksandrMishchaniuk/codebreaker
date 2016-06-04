module Codebreaker
  class Manager
    include Codebreaker::Messages
    include Codebreaker::Asks
    ATTEMPTS = 5
    HINTS = 1
    FILE_NAME = 'results.data.txt'
    FILE_DIR = 'data'
    FILE_PATH = FILE_DIR+'/'+FILE_NAME

    attr_accessor :user_name, :game
    
    def initialize
      @attempts_count = nil
      @hints_count = nil
      @game = nil
      @user_name = nil
      welcome
    end

    def start
      begin
        flag = false
        text = ask_action
        case text
          when 'q'
            exit
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
        text = ask_start_game
        case text
          when 'q'
            exit
          when 'g'
            start_game
          else
            flag = true
            wrong_input
        end
      end while flag
    end

    def start_game
      set_variables(ATTEMPTS, HINTS)
      @game.start
      while attempts?
        next unless make_attempt
        you_win
        break
      end
      you_lose unless attempts? 
      save_game?
    end

    def make_attempt
      begin
        flag = false
        text = ask_guess
        case text
          when 'q'
            exit
          when 'h'
            flag = true
            get_hint
          when /^[1-6]{4}$/
            return check_guess(text)
          else
            flag = true
            wrong_input
        end
      end while flag
    end

    def check_guess(guess)
      res = guess_result(guess)
      puts res
      return true if res == '++++'
      false
    end

    def get_hint
      if hints?
        h = hint_result
        puts h
        h
      else
        no_hints
        false
      end
    end

    def save_game?
      begin
        flag = false
        text = ask_save
        case text
          when 'q'
            exit
          when 'n'
            start
          when 'y'
            save_game
          else
            flag = true
            wrong_input
        end
      end while flag
    end

    def save_game
      begin
        flag = false
        text = ask_user_name
        case text
          when 'q'
            exit
          when user_name_pattern
            @user_name = text
            save_game_data
            start
          else
            flag = true
            wrong_input
        end
      end while flag
    end

    def print_results
      puts "User name\t\tGame status\tAtt\tHints\tDate and time"
      print get_saved_results
    end

    def save_game_data
      Dir.mkdir(FILE_DIR) unless Dir.exist?(FILE_DIR)
      File.open(FILE_PATH, 'a') do |f|
        f.puts(get_string_for_save)
      end
    end

    def get_saved_results
      begin
        File.read(FILE_PATH)
      rescue
        puts "No any results yet"
      end
    end

    def get_string_for_save
      t = Time.new
      time_str = t.strftime("%Y-%m-%d %H:%M")
      status = (@attempts_count > 0)? 'win': 'lose'
      attempts = (@attempts_count > 0)? "#{ATTEMPTS - @attempts_count + 1}": "all"
      str = "#{@user_name}\t\t\t| #{status}\t\t"
      str += "| #{attempts}\t"
      str += "| #{HINTS - @hints_count}\t| #{time_str}"
      str
    end

    def set_variables(attempts, hints)
      @attempts_count = attempts
      @hints_count = hints
      @game = Game.new
    end

    def get_variables
      [@attempts_count, @hints_count]
    end

    def guess_result(guess)
      res = @game.check_guess(guess)
      @attempts_count -= 1 unless res == '++++'
      res
    end

    def hint_result
      @hints_count -= 1
      @game.get_hint
    end

    def attempts?
      @attempts_count > 0
    end

    def hints?
      @hints_count > 0
    end

    def user_name_pattern
      /^[. \w-]+$/
    end

  end
end