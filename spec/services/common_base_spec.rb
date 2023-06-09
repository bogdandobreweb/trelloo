# frozen_string_literal: true

require 'rails_helper'
# require '../../app/services/boards/boards_collector.rb'

RSpec.describe CommonBase do
  let(:board_collector) { Boards::BoardsCollector.new }
  describe '.model' do
    context 'when called on a class with an explicit model method' do
      it 'returns the model of that class' do
        expect(board_collector.model).to eq(Board)
      end
    end

    context 'when called on a class that inherits from CommonBase' do
      it 'returns the class itself' do
        expect(Boards::BoardsCollector.new.model).to eq(Board)
      end
    end
  end

  describe '.call' do
    it 'raises an error' do
      expect { described_class.call }.to raise_error(RuntimeError, 'Must be implemented in inheriting class')
    end
  end

  describe '.needed_before_call' do
    it 'calls the prerequisites method' do
      object = described_class.new
      expect(object).to receive(:prerequisites)
      object.needed_before_call
    end
  end

  describe '.needed_after_call' do
    it 'returns nothing' do
      object = described_class.new
      expect(object.needed_after_call).to be_nil
    end
  end
end
