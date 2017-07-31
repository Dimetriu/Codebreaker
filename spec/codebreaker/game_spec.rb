require "spec_helper"

module Codebreaker
  RSpec.describe Game do
    subject(:game) { Game.new }

    RSpec.shared_examples "an exact_match" do
      context "exact_match" do
        it "checks the exact match between secret code and user guess" do
          guess = game.instance_variable_get(:@secret)
          expect(game.instance_variable_get(:@secret)).to eq(guess)
        end
      end
    end

    it "provides a ten turns" do
      expect(game.instance_variable_get(:@turns)).to eq(10)
    end

    it "checks a hint availability to true" do
      expect(game.instance_variable_get(:@hint)).to be true
    end

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

      context ".decrement_turn" do

        it "decremets turns count" do
          expect{game.decrement_turn}.to change{game.turns}.from(10).to(9)
        end
      end

      context ".exact_match(guess)" do

        it_behaves_like "an exact_match" do
          let(:guess) { game.exact_match(game.instance_variable_get(:@secret)) }
        end

        it "checks that match between secret code and user guess is not the exact" do
          guess = "1234".split
          game.exact_match(guess)
          expect(game.instance_variable_get(:@secret)).not_to eq(guess)
        end
      end

      context ".check" do

        
      end
    end
  end
end
