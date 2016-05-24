require 'spec_helper'

module Codebreaker
  RSpec.describe Manager do

    describe '#initialize' do
      context 'when manager instance created' do
        it { expect(subject.instance_variable_get(:@msg_start)).not_to be_empty }
        it { expect(subject.instance_variable_get(:@count_attempts)).not_to be_falsey }
        it { expect(subject.instance_variable_get(:@count_hints)).not_to be_falsey }
        it { expect(subject.instance_variable_get(:@game)).to be_nil }
        it { expect(subject.instance_variable_get(:@user_name)).to be_empty }
      end
    end
    
    describe '#init' do
      context 'when manager init' do
        it do
          name = 'some name'
          allow(subject).to receive(:ask_name).and_return(name)
          message = subject.instance_variable_get(:@msg_start)
          expect{ subject.init }.to output(message).to_stdout
          expect(subject.instance_variable_get(:@user_name)).to eql(name)
        end
      end
    end

    describe '#start_game' do
      before do
        subject.start_game
      end
      context 'when game started' do
        it { expect(subject.instance_variable_get(:@game)).to be_instance_of(Game) }
      end
    end

  end
end