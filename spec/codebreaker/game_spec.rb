require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    
    describe '#start' do
      before do
        subject.start
      end

      it 'generates secret code' do
        expect(subject.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(subject.instance_variable_get(:@secret_code).size).to eq(4)
      end
      
      it 'saves secret code with numbers from 1 to 6' do
        expect(subject.instance_variable_get(:@secret_code)).to match(/^[1-6]+$/)
      end
    end

    describe '#check_guess' do
      secret_code = "4234"
      secret_code_2 = "1221"
      context "when secret code #{secret_code}" do
        before do
          subject.instance_variable_set(:@secret_code, secret_code)
        end
        [
          ['5636','+'], ['5436','+-'], ['2444','+--'], ['3424','+---'],
          ['6254','++'], ['3254','++-'], ['4432','++--'], ['4334','+++'],
          ['4234','++++'], ['1651',''], ['3356','-'],
          ['5441','--'], ['3412','---'], ['3442','----']
        ].each do |item|
          it 'and guess '+item[0] do
            expect(subject.check_guess(item[0])).to eq(item[1])
          end
        end
      end
      context "when secret code #{secret_code_2}" do
        it 'and guess 2112' do
          subject.instance_variable_set(:@secret_code, secret_code_2)
          expect(subject.check_guess('2112')).to eq('----')
        end
      end
    end

    describe '#get_hint' do
      secret_code = "6234"
      context "when secret code #{secret_code}" do
        before do
          subject.instance_variable_set(:@secret_code, secret_code)
        end
        it { expect(secret_code).to include(subject.get_hint) }
      end
    end

  end
end