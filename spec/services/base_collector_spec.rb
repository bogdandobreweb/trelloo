require 'rails_helper'

RSpec.describe BaseCollector do
  before do 
    Board.create(name: "Test Board 1")
    Board.create(name: "Test Board 2")
  end
  let(:boards) { Board.all }

  let(:board_collector) { Boards::BoardsCollector.new(base_filter_service: Boards::BoardsFilter.new)}

  describe '.call' do
    context 'when records are present' do
      it 'returns the records' do
        expect(board_collector.call).to eq(boards)
      end
    end

    context 'when records are not present' do
      it 'adds an error to the collector' do
        allow(board_collector.model).to receive(:all).and_return([])
        expect(board_collector.call).to eq([message: "Failed to collect !", traceback: []])
      end
    end
  end

  describe '.model' do
    context 'when called on an object' do
      it 'returns the model of the object class' do
        expect(board_collector.model).to eq(Board)
      end
    end

    context 'when called on a class' do
      it 'returns the model of that class' do
        expect(Boards::BoardsCollector.new.model).to eq(Board)
      end
    end
  end
end