require "codebreaker/version"
require "codebreaker/game"
require "codebreaker/ui"

module Codebreaker
  game = Ui.new
  game.play
  game.info
end
