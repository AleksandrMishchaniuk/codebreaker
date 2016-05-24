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

    describe '#guess_processing' do
      SECRET_CODE = "4234"
      context 'when secret code '+SECRET_CODE do
        before do
          subject.instance_variable_set(:@secret_code, SECRET_CODE)
        end
        [
          ['5636','+'], ['5436','+-'], ['2444','+--'], ['3424','+---'],
          ['6254','++'], ['3254','++-'], ['4432','++--'], ['4334','+++'],
          ['4234','++++'], ['1651',''], ['3356','-'],
          ['5441','--'], ['3412','---'], ['3442','----']
        ].each do |item|
          it 'and guess '+item[0] do
            expect(subject.guess_processing(item[0])).to eq(item[1])
          end
        end
      end
    end

  end
end