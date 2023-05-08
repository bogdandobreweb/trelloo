require 'rails_helper'

RSpec.describe Comments::CommentUpdater do
  let(:user) { User.create(email: 'test@example.com', password: 'password') }
  let(:board) { Board.create(name: 'Test Board') }
  let(:story) { Story.create(name: 'Test Story', board:, user_id: user.id, column_id: 1) }
  let(:comment) { Comment.create(body: 'Test Comment', user_id: user.id, story_id: story.id) }
  let(:attrs) { { id: comment.id, body: 'Updated Comment Body' } }
  let(:comment_updater) { Comments::CommentUpdater.new }

  describe '.call' do
    context 'when record is successfully updated' do
      it 'returns the updated record' do
        expect(comment_updater.call(attrs)).to eq(comment.reload)
        expect(comment.body).to eq('Updated Comment Body')
      end
    end

    context 'when record is not found' do
      let(:attrs) { { id: 0 } }

      it 'raises error' do
        expect(comment_updater.call(attrs)).to eq(nil)
        expect(comment_updater.errors).not_to be_empty
      end
    end

    context 'when update attributes are missing' do
      let(:attrs) { { id: comment.id } }

      it 'adds an error to the updater' do
        expect(comment_updater.call(attrs)).to eq(nil)
        expect(comment_updater.errors).not_to be_empty
      end
    end

    context 'when record update fails' do
      let(:attrs) { { id: comment.id, body: '' } }

      it 'raises an error' do
        expect(comment_updater.call(attrs)).to eq(nil)
        expect(comment_updater.errors).not_to be_empty
      end
    end
  end

  describe '.model' do
    it 'returns the Comment model' do
      expect(comment_updater.model).to eq(Comment)
    end
  end
end
