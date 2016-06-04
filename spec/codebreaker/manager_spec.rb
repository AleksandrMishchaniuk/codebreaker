require 'spec_helper'

module Codebreaker
  RSpec.describe Manager do

    before {allow(subject).to receive(:exit)}

    describe '#start' do
      after(:each) { subject.start }
      context "when user types 'q'" do
        it do
          allow(subject).to receive(:ask_action).and_return('q')
          expect(subject).to receive(:exit)
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
        it do
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
          allow(subject).to receive(:ask_start_game).and_return('q')
          expect(subject).to receive(:exit)
        end
      end
      context "when user types 'g'" do
        it do
          allow(subject).to receive(:ask_start_game).and_return('g')
          expect(subject).to receive(:start_game)
        end
      end
    end

    describe '#start_game' do
      context 'when game started' do
        before do
          allow(subject).to receive(:make_attempt).and_return(true)
          allow(subject).to receive(:save_game?)
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
            allow(subject).to receive(:save_game?)
            expect(subject).to receive(:make_attempt).at_least(:once)
          end
        end
      end
    end

    describe '#make_attempt' do
      after(:each) { subject.make_attempt }
      context "when user types 'q'" do
        it do
          allow(subject).to receive(:ask_guess).and_return('q')
          expect(subject).to receive(:exit)
        end
      end
      context "when user types 'h'" do
        it do
          allow(subject).to receive(:ask_guess).and_return('h', 'q')
          expect(subject).to receive(:ask_guess).at_least(:once)
          expect(subject).to receive(:get_hint)
        end
      end
      context "when user types guess (four numbers)" do
        it do
          game = Game.new
          game.start
          code = game.instance_variable_get(:@secret_code)
          allow(subject).to receive(:ask_guess).and_return(code)
          expect(subject).to receive(:check_guess).with(/^[1-6]{4}$/)
        end
      end
      context "when user types another string" do
        it do
          allow(subject).to receive(:ask_guess).and_return('another string', 'q')
          expect(subject).to receive(:ask_guess).at_least(:once)
          expect(subject).to receive(:wrong_input)
        end
      end
    end

    describe '#check_guess' do
      let(:game){ Game.new }
      before do
        game.start
        subject.instance_variable_set(:@game, game)
      end
      context 'when user is guessing secret code' do
        it do
          guess = game.instance_variable_get(:@secret_code)
          expect(subject.check_guess(guess)).to be true
        end
      end
      context 'when user is not guessing secret code' do
        it do
          subject.instance_variable_set(:@attempts_count, 1)
          guess = game.instance_variable_get(:@secret_code).reverse
          expect{ subject.check_guess(guess) }.to change{ subject.instance_variable_get(:@attempts_count) }
          expect(subject.check_guess(guess)).to be false
        end
      end
    end

    describe '#get_hint' do
      let(:game){ Game.new }
      before do
        game.start
        subject.instance_variable_set(:@game, game)
      end
      context 'when hints count is 0' do
        before { subject.instance_variable_set(:@hints_count, 0) }
        it { expect(subject.get_hint).to be false }
        it do
          expect(subject).to receive(:no_hints)
          subject.get_hint
        end
      end
      context 'when hints count is not 1 or more' do
        before { subject.instance_variable_set(:@hints_count, 1) }
        it do
          code = game.instance_variable_get(:@secret_code)
          expect(code).to include(subject.get_hint)
        end
        it do
          expect{ subject.get_hint }.to change{ subject.instance_variable_get(:@hints_count) }
        end
      end
    end

    describe '#save_game?' do
      after(:each) { subject.save_game? }
      context "when user types 'q'" do
        it do
          allow(subject).to receive(:ask_save).and_return('q')
          expect(subject).to receive(:exit)
        end
      end
      context "when user types 'n'" do
        it do
          allow(subject).to receive(:ask_save).and_return('n')
          expect(subject).to receive(:start)
        end
      end
      context "when user types 'y'" do
        it do
          allow(subject).to receive(:ask_save).and_return('y')
          expect(subject).to receive(:save_game)
        end
      end
      context "when user types another string" do
        it do
          allow(subject).to receive(:ask_save).and_return('another string', 'q')
          expect(subject).to receive(:ask_save).at_least(:once)
          expect(subject).to receive(:wrong_input)
        end
      end
    end

    describe '#save_game' do
      after(:each) { subject.save_game }
      context "when user types 'q'" do
        it do
          allow(subject).to receive(:ask_user_name).and_return('q')
          expect(subject).to receive(:exit)
        end
      end
      context "when user types corect name" do
        it do
          allow(subject).to receive(:ask_user_name).and_return('some name._-')
          expect(subject).to receive(:save_game_data)
          expect(subject).to receive(:start)
        end
      end
      context "when user types another string" do
        it do
          allow(subject).to receive(:ask_user_name).and_return('another > string', 'q')
          expect(subject).to receive(:ask_user_name).at_least(:once)
          expect(subject).to receive(:wrong_input)
        end
      end
    end

    describe 'read and save results to file' do
      let(:tmp_file_path){'data/results_test.data.txt'}
      after do
        File.delete(tmp_file_path)
        Dir.rmdir('data')
      end
      it do
        stub_const("#{described_class}::FILE_PATH", tmp_file_path)
        subject.instance_variable_set(:@user_name, 'test')
        subject.instance_variable_set(:@attempts_count, 0)
        subject.instance_variable_set(:@hints_count, 1)
        subject.save_game_data
        subject.save_game_data
        str = subject.get_string_for_save + "\n"
        expect(subject.get_saved_results).to eq(str + str)
      end
    end

  end
end