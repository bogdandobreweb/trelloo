require 'rails_helper'

RSpec.describe BaseUpdater do
  let(:board) { Board.create(name: 'Andrei') }
  let(:attrs) { { id: board.id, name: 'New Board Name' } }
  let(:board_updater) { Boards::BoardUpdater.new }

  describe '.call' do
    context 'when record is successfully updated' do
      it 'returns the updated record' do
        expect(board_updater.call(attrs)).to eq(board.reload)
      end
    end

    context 'when record is not found' do
      let(:attrs) { { id: 0 } }
      it 'raises error' do
        expect(board_updater.call(attrs)).to eq(nil)
        expect(board_updater.errors).not_to be_empty
      end
    end

    context 'when update attributes are missing' do
      let(:attrs) {}

      it 'adds an error to the updater' do
        expect(board_updater.call(attrs)).to eq(nil)
      end
    end

    context 'when record update fails' do
      let(:attrs) { { id: board.id, name: '' } }
      it 'raises an error' do
        expect(board_updater.call(attrs)).to eq(nil)
        expect(board_updater.errors).not_to be_empty
      end
    end
  end

  describe '.model' do
    context 'when called on an object' do
      it 'returns the model of the object class' do
        expect(board_updater.model).to eq(Board)
      end
    end

    context 'when called on a class' do
      it 'returns the model of that class' do
        expect(Boards::BoardUpdater.new.model).to eq(Board)
      end
    end
  end
end
