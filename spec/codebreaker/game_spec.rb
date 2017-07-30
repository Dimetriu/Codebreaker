require "spec_helper"

module Codebreaker
  RSpec.describe Game do
    subject(:game) { Game.new }

    context ".start" do

      before do
        game.start
      end

      it "saves secret code" do
        expect(game.instance_variable_get(:@secret)).not_to be_empty
      end

      it "saves 4 numbers of secret code" do
        expect(game.instance_variable_get(:@secret).size).to eq(4)
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret).join).to match(/[1-6]+/)
      end

      context ".use_a_hint" do

        it "checks a hint availability to true" do
          expect(game.instance_variable_get(:@hint)).to be true
        end

        it "provides a hint" do
          game.use_a_hint
          expect(game.instance_variable_get(:@secret).join)
          .to include(game.instance_variable_get(:@secret).shuffle.take(1).join)
        end

        it "provides a hint only once" do
          game.use_a_hint
          expect(game.instance_variable_get(:@hint)).to be false
        end
      end
    end
  end
end
