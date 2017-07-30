require "yaml"

module Codebreaker
  class Game
    attr_reader :secret, :hint, :turns

    def initialize
      @secret = ""
      @hint = true
      @turns = 10
    end

    def start
      @secret = generate
    end

    def generate
      (1..4).map { rand(1..6) }
    end

    def use_a_hint
      return false if @hint == false
      p @secret.shuffle.take(1).join
      @hint = false
    end

    def decrement_turn
      @turns -= 1
    end

    def exact_match(guess)
      @secret == guess
    end

    def limit_condition(guess)
      exact_match(guess) || @turns < 1
    end

    def loose_condition(guess)
      !exact_match(guess) && @turns == 0
    end

    def check(guess, result = [])
      return false if @secret == guess
      @secret = position_match(guess, result)
      number_match(guess, result)
      p result.join
    end

    def position_match(guess, result)
      @secret.zip(guess.take(@secret.size)).delete_if do |position|
        result << "+" if position[0] == position[1]
      end.transpose.delete_at(0)
    end

    def number_match(guess, result)
      guess.each_index do |number|
        result << "-" if guess.uniq.include? @secret.uniq[number]
      end
    end
  end
end
