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
  end
end
