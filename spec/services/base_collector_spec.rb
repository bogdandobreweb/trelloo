require '../rails_helper.rb'
require '../../app/services/boards/boards_collector.rb'
require '../../app/services/boards/boards_filter.rb'


RSpec.describe BaseCollector do
  let(:boards) { [Board.create(name: "Test Board 1"), Board.create(name: "Test Board 2")] }

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
        board_collector.call
        expect(board_collector.errors).to include(message: "Failed to collect !", traceback: nil)
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
        expect(Boards::BoardsCollector.new.model).to eq(Object)
      end
    end
  end
end