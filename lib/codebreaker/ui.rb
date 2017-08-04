require "yaml"
require_relative "game"
require_relative "service"

module Codebreaker
  class Ui < Service

    def play
      @game.start
      initialize_playground
      gameplay
      message(:game_over) if loose
    end

    def info
        p "Game session:  #{self.object_id}"
        p "Name:          #{@user_name}"
        p "Secret Code:   #{@game.secret.join}"
        p "Hint not used: #{@game.hint}"
        p "Turns left     #{@game.turns}"
    end
  end
end
