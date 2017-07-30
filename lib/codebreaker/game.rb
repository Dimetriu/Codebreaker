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
  end
end
