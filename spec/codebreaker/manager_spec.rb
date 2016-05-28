require 'spec_helper'

module Codebreaker
  RSpec.describe Manager do

    describe '#start' do
      after(:each) { subject.start }
      context "when user types 'q'" do
        it do
          allow(subject).to receive(:ask_action).and_return('q')
          expect(subject).to receive(:quit)
        end
      end
      context "when user types 'r'" do
        it do
          allow(subject).to receive(:ask_action).and_return('r')
          expect(subject).to receive(:print_results)
          expect(subject).to receive(:start_game?)
        end
      end
      context "when user types 'g'" do
        it do
          allow(subject).to receive(:ask_action).and_return('g')
          expect(subject).to receive(:start_game)
        end
      end
      context "when user types another string" do
        it "shoulg user input again" do
          allow(subject).to receive(:ask_action).and_return('another string', 'q')
          expect(subject).to receive(:ask_action).at_least(:once)
          expect(subject).to receive(:wrong_input)
        end
      end
    end

    describe '#start_game?' do
      after(:each) { subject.start_game? }
      context "when user types 'q'" do
        it do
          allow(subject).to receive(:ask_action).and_return('q')
          expect(subject).to receive(:quit)
        end
      end
      context "when user types 'g'" do
        it do
          allow(subject).to receive(:ask_action).and_return('g')
          expect(subject).to receive(:start_game)
        end
      end
    end

    describe '#start_game' do
      context 'when game started' do
        before do
          allow(subject).to receive(:make_attempt).and_return(true)
          subject.start_game
        end
        it { expect(subject.instance_variable_get(:@attempts_count)).not_to be_nil }
        it { expect(subject.instance_variable_get(:@hints_count)).not_to be_nil }
        it { expect(subject.instance_variable_get(:@game)).to be_instance_of(Game) }
      end
      context 'when attempts count is 0' do
        it do
          expect(subject).to receive(:you_lose).once
          expect(subject).to receive(:save_game?)
          allow(subject).to receive(:make_attempt) do
            subject.instance_variable_set(:@attempts_count, 0)
            false
          end
          subject.start_game
        end
      end
      context 'when attempts count is 1 or more' do
        after(:each) { subject.start_game }
        context 'when attempt is true' do
          it do
            expect(subject).to receive(:you_win).once
            expect(subject).to receive(:save_game?)
            allow(subject).to receive(:make_attempt).and_return(true)
          end
        end
        context 'when attempt is false' do
          it do
            allow(subject).to receive(:make_attempt).and_return(false, true)
            expect(subject).to receive(:make_attempt).at_least(:once)
          end
        end
      end
    end





    describe '#initialize' do
      context 'when manager instance created' do
        # it { expect(subject.instance_variable_get(:@msg_start)).not_to be_empty }
        # it { expect(subject.instance_variable_get(:@count_attempts)).not_to be_falsey }
        # it { expect(subject.instance_variable_get(:@count_hints)).not_to be_falsey }
        # it { expect(subject.instance_variable_get(:@game)).to be_nil }
        # it { expect(subject.instance_variable_get(:@user_name)).to be_empty }
      end
    end
    
    describe '#init' do
      context 'when manager init' do
        # it do
        #   name = 'some name'
        #   allow(subject).to receive(:ask_name).and_return(name)
        #   message = subject.instance_variable_get(:@msg_start)
        #   expect{ subject.init }.to output(message).to_stdout
        #   expect(subject.instance_variable_get(:@user_name)).to eql(name)
        # end
      end
    end

    describe '#start_game' do
      before do
        subject.start_game
      end
      context 'when game started' do
        # it { expect(subject.instance_variable_get(:@game)).to be_instance_of(Game) }
      end
    end

  end
end