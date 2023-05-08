# frozen_string_literal: true

require 'rails_helper'
# require '../../app/services/boards/board_creator.rb'

RSpec.describe BaseCreator do
  let(:attrs) { { name: 'Test Board 1' } }
  let(:board_creator) { Boards::BoardCreator.new }

  describe '.call' do
    context 'when record is successfully created' do
      it 'returns the created record' do
        expect(board_creator.call(attrs)).to be_instance_of(Board)
      end
    end

    context 'when record creation fails' do
      let(:attrs) {}
      it 'adds an error to the creator' do
        expect(board_creator.call(attrs)).to eq(nil)
      end
    end
  end

  describe '.model' do
    context 'when called on an object' do
      it 'returns the model of the object class' do
        expect(board_creator.model).to eq(Board)
      end
    end

    context 'when called on a class' do
      it 'returns the model of that class' do
        expect(Boards::BoardCreator.new.model).to eq(Board)
      end
    end
  end
end
