require 'rails_helper'
# require '../../app/services/stories/stories_filter.rb'

RSpec.describe BaseFilter do
  let(:filter) { Stories::StoriesFilter.new }

  describe '#call' do
    it 'returns all stories' do
      stories = [Story.create(name: 'Story1', description: 'A', column_id: 1),
                 Story.create(name: 'Story2', description: 'B', column_id: 2)]
      allow(Story).to receive(:all).and_return(stories)
      expect(filter.call).to eq(stories)
    end

    it 'passes options to the model' do
      options = { column_id: 1 }
      expect(Story).to receive(:where).with(hash_including(options))
      filter.call(options:)
    end
  end
end
