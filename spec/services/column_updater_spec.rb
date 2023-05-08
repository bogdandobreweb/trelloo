require 'rails_helper'

RSpec.describe Columns::ColumnUpdater do
  let(:column) { Column.create(name: 'Column Name', order_id: 5) }
  let(:attrs) { { id: column.id, name: 'New Column Name' } }
  let(:column_updater) { Columns::ColumnUpdater.new }

  describe '.call' do
    context 'when record is successfully updated' do
      it 'returns the updated record' do
        expect(column_updater.call(attrs)).to eq(column.reload)
      end
    end

    context 'when record is not found' do
      let(:attrs) { { id: 0 } }
      it 'raises error' do
        expect(column_updater.call(attrs)).to eq(nil)
        expect(column_updater.errors).not_to be_empty
      end
    end

    context 'when update attributes are missing' do
      let(:attrs) {}

      it 'adds an error to the updater' do
        expect(column_updater.call(attrs)).to eq(nil)
      end
    end

    context 'when record update fails' do
      let(:attrs) { { name: '', order_id: 0 } }
      it 'raises an error' do
        expect(column_updater.call(attrs)).to eq(nil)
        expect(column_updater.errors).not_to be_empty
      end
    end
  end

  describe '.model' do
    context 'when called on an object' do
      it 'returns the model of the object class' do
        expect(column_updater.model).to eq(Column)
      end
    end

    context 'when called on a class' do
      it 'returns the model of that class' do
        expect(Columns::ColumnUpdater.new.model).to eq(Column)
      end
    end
  end
end
