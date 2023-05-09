# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoryPolicy do
  subject { described_class }
  let(:user1) { User.create(id: 1) }
  let(:user2) { User.create(id: 2) }
  let(:user3) { User.create(id: 3) }
  let(:admin_role) { Role.create(name: 'admin') }
  let(:manager_role) { Role.create(name: 'manager') }
  let(:developer_role) { Role.create(name: 'developer') }
  let(:story) { Story.create(name: 'Story') }

  before do
    admin_role.update(user_id: user1.id)
    manager_role.update(user_id: user2.id)
    developer_role.update(user_id: user3.id)

    user1.roles << admin_role
    user2.roles << manager_role
    user3.roles << developer_role
  end

  permissions :index?, :show? do
    it 'allows admin to see all stories' do
      expect(subject).to permit(user1, story)
    end

    it 'allows manager to see a story' do
      expect(subject).to permit(user2, story)
    end

    it 'allows developer to see a story' do
      expect(subject).to permit(user3, story)
    end
  end

  permissions :update?, :edit? do
    it 'allows admin to update and edit all stories' do
      expect(subject).to permit(user1, story)
    end

    it 'allows manager to update and edit a story' do
      expect(subject).to permit(user2, story)
    end

    it 'does not allow developer to update or edit a story' do
      expect(subject).not_to permit(user3, story)
    end
  end

  permissions :create? do
    it 'allows admin to create a story' do
      expect(subject).to permit(user1, story)
    end

    it 'allows manager to create a story' do
      expect(subject).to permit(user2, story)
    end

    it "doesn't allow developer to create a story" do
      expect(subject).to_not permit(user3, story)
    end
  end

  permissions :destroy? do
    it 'allows admin to destroy a story' do
      expect(subject).to permit(user1, story)
    end

    it "doesn't allow manager to destroy a story" do
      expect(subject).to_not permit(user2, story)
    end

    it "doesn't allow developer to destroy a story" do
      expect(subject).to_not permit(user3, story)
    end
  end
end
