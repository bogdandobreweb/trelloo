require 'rails_helper'

RSpec.describe Stories::StoryUpdater do
  let(:board) { Board.create(name: 'Board Name') }
  let(:story) { Story.create(name: 'Story Name', description: 'dadada', column_id: 1, board_id: board.id) }
  let(:attrs) { { id: story.id, name: 'New Story Name' } }
  let(:story_updater) { Stories::StoryUpdater.new }

  describe '.call' do
    context 'when record is successfully updated' do
      it 'returns the updated record' do
        expect(story_updater.call(attrs)).to eq(story.reload)
      end
    end

    context 'when record is not found' do
      let(:attrs) { { id: 0 } }
      it 'raises error' do
        expect(story_updater.call(attrs)).to eq(nil)
        expect(story_updater.errors).not_to be_empty
      end
    end

    context 'when update attributes are missing' do
      let(:attrs) {}

      it 'adds an error to the updater' do
        expect(story_updater.call(attrs)).to eq(nil)
        expect(story_updater.errors).not_to be_empty
      end
    end

    context 'when record update fails' do
      let(:attrs) { { id: story.id, name: '' } }
      it 'raises an error' do
        expect(story_updater.call(attrs)).to eq(nil)
        expect(story_updater.errors).not_to be_empty
      end
    end
  end

  describe '.model' do
    context 'when called on an object' do
      it 'returns the model of the object class' do
        expect(story_updater.model).to eq(Story)
      end
    end

    context 'when called on a class' do
      it 'returns the model of that class' do
        expect(described_class.new.model).to eq(Story)
      end
    end
  end
end
