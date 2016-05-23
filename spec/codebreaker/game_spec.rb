require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    describe '#start' do
      it 'generates secret code' do
        game = Game.new
        game.start
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        game = Game.new
        game.start
        expect(game.instance_variable_get(:@secret_code).size).to eq(4)
      end
      
      it 'saves secret code with numbers from 1 to 6' do
        game = Game.new
        game.start
        expect(game.instance_variable_get(:@secret_code)).to match(/^[1-6]+$/)
      end
    end
  end
end