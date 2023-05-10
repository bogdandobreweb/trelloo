# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class }
  let(:user1) { User.create(id: 1) }
  let(:user2) { User.create(id: 2) }
  let(:user3) { User.create(id: 3) }
  let(:admin_role) { Role.create(name: 'admin') }
  let(:manager_role) { Role.create(name: 'manager') }
  let(:developer_role) { Role.create(name: 'developer') }
  let(:comment) { Comment.create(name: 'Comment') }

  before do
    admin_role.update(user_id: user1.id)
    manager_role.update(user_id: user2.id)
    developer_role.update(user_id: user3.id)

    user1.roles << admin_role
    user2.roles << manager_role
    user3.roles << developer_role
  end

  permissions :index?, :show? do
    it 'allows admin to see all comments' do
      expect(subject).to permit(user1, comment)
    end

    it 'allows manager to see a comment' do
      expect(subject).to permit(user2, comment)
    end

    it 'allows developer to see a comment' do
      expect(subject).to permit(user3, comment)
    end
  end

  permissions :update?, :edit? do
    it 'allows admin to update and edit all comments' do
      expect(subject).to permit(user1, comment)
    end

    it 'allows manager to update and edit a comment' do
      expect(subject).to permit(user2, comment)
    end

    it 'does not allow developer to update or edit a comment' do
      expect(subject).not_to permit(user3, comment)
    end
  end

  permissions :create? do
    it 'allows admin to create a comment' do
      expect(subject).to permit(user1, comment)
    end

    it 'allows manager to create a comment' do
      expect(subject).to permit(user2, comment)
    end

    it "doesn't allow developer to create a comment" do
      expect(subject).to_not permit(user3, comment)
    end
  end

  permissions :destroy? do
    it 'allows admin to destroy a comment' do
      expect(subject).to permit(user1, comment)
    end

    it "doesn't allow manager to destroy a comment" do
      expect(subject).to_not permit(user2, comment)
    end

    it "doesn't allow developer to destroy a comment" do
      expect(subject).to_not permit(user3, comment)
    end
  end
end
