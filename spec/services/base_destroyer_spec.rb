require 'rails_helper'
# require '../../app/services/boards/board_destroyer.rb'

RSpec.describe BaseDestroyer do
  let!(:board) { Board.create(name: "Test Board") }
  let(:destroyer) { Boards::BoardDestroyer.new }
  
  describe '#call' do
    context 'when record exists' do
      it 'destroys the record' do
        expect { destroyer.call(board.id) }.to change(Board, :count).by(-1)
        expect { Board.find(board.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when record does not exist' do
      it 'does not destroy any records and adds an error message' do
        expect { destroyer.call(0) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    context 'when record does not exist' do
      it 'does not destroy any records and adds an error message' do
        expect { destroyer.call(0) }.to raise_error(ActiveRecord::RecordNotFound)
        expect(destroyer.errors).to eq(["Board not found!"])
      end
    end
  end
  
  describe '.model' do
    context 'when called on an object' do
      it 'returns the model of the object class' do
        expect(destroyer.model).to eq(Board)
      end
    end

    context 'when called on a class' do
      it 'returns the model of that class' do
        expect(Boards::BoardDestroyer.new.model).to eq(Board)
      end
    end
  end
end