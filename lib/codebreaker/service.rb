require_relative "ui"

module Codebreaker
  class Service
    attr_accessor :guess, :user_name
    attr_reader :game

    def initialize
      @game = Game.new
      @guess = ""
      @user_name = ""
      @info = @game.turns
      @messages = YAML.load(File.open(File.join(File.dirname(__FILE__), "../yaml/messages.yml")))
    end

    def gameplay
      loop do
        process_turn
        turn_info unless limitate
        break if limitate
      end
      play_again?
    end

    private

    def intro
      message(:intro)
      @user_name = gets.chomp.capitalize
      validate_name
      print "#{@user_name}, "
      message(:welcome)
    end

    def initialize_playground
      intro
      message(:rules)
      message(:warn)
    end

    def message(text)
      print "#{@messages[:message][text]}" + "\n"
    end

    def hint
      message(:approach)
      @game.use_a_hint if gets.chomp == "h"
    end

    def win
      print "#{message(:win)}#{@user_name}, you has hacked a secret code in #{@info - @game.turns} turns" + "\n"
    end

    def turn_info
      print "#{@game.turns}" + " turn(s) left" + "\n"
    end

    def make_a_guess
      @guess = /[1-6]+/.match(gets.chomp).to_s.each_char.to_a
      .map { |guess| guess.to_i }.take(@game.secret.size)
    end

    def limitate
      @game.limit_condition(@guess)
    end

    def loose
      @game.loose_condition(@guess)
    end

    def validate_name
      @user_name = ("a".."z").to_a.shuffle.take(6).join.capitalize if @user_name.empty?
    end

    def check_exact_match
      return win if @game.exact_match(@guess)
    end

    def process_turn
      hint unless @game.hint == false
      @game.decrement_turn
      make_a_guess
      check_exact_match
      @game.check(@guess)
    end

    def inline_template(col1, col2, col3)
      print "\ngame:\t#{col1}\n".upcase + "name:\t#{col2}\n".upcase + "turns:\t#{col3}\n".upcase + "\n"
    end

    def play_again?
      message(:try_again)
      Ui.new.play if gets.chomp == "y"
    end
  end
end
