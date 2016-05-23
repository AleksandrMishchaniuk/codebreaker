require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }
    
    describe '#start' do

      before do
        game.start
      end

      it 'generates secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq(4)
      end
      
      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/^[1-6]+$/)
      end
    end

    describe '#guess_processing' do

      before do
        game.instance_variable_set(:@secret_code, '1234')
      end

      it 'when secret code "1234"' do
        expect(game.guess_processing('1234')).to eq('++++')
        expect(game.guess_processing('5656')).to eq('')
        expect(game.guess_processing('1222')).to eq('++')
        expect(game.guess_processing('4321')).to eq('----')
        expect(game.guess_processing('5445')).to eq('-')
        expect(game.guess_processing('6435')).to eq('-+')
      end

    end

    describe '#check_exact_match' do
      it do
        expect(game.check_exact_match('1111', '1111')).to eq([ '++++', '++++' ])
        expect(game.check_exact_match('1212', '2121')).to eq([ '1212', '2121' ])
        expect(game.check_exact_match('1212', '2222')).to eq([ '1+1+', '2+2+' ])
        expect(game.check_exact_match('6223', '3422')).to eq([ '62+3', '34+2' ])
      end
    end

    describe '#check_number_match' do
      it do
        expect(game.check_number_match('++++', '++++')).to eq('++++')
        expect(game.check_number_match('1212', '2121')).to eq('----')
        expect(game.check_number_match('1+1+', '2+2+')).to eq('++')
        expect(game.check_number_match('62+3', '34+2')).to eq('-+-')
        expect(game.check_number_match('6565', '2314')).to eq('')
        expect(game.check_number_match('6565', '2354')).to eq('-')
      end
    end

  end
end