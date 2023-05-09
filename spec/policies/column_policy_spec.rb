# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ColumnPolicy do
  subject { described_class }
  let(:admin_role) { Role.create(name: 'admin') }
  let(:manager_role) { Role.create(name: 'manager') }
  let(:developer_role) { Role.create(name: 'developer') }
  let(:user1) { User.create(id: 1, role_id: admin_role.id) }
  let(:user2) { User.create(id: 2, role_id: manager_role.id) }
  let(:user3) { User.create(id: 3, role_id: developer_role.id) }
  let(:column) { Column.create(name: 'Column', order_id: 4) }

  before do
    admin_role.update(user_id: user1.id)
    manager_role.update(user_id: user2.id)
    developer_role.update(user_id: user3.id)

    user1.roles << admin_role
    user2.roles << manager_role
    user3.roles << developer_role
  end

  permissions :index?, :show? do
    it 'allows admin to see all columns' do
      expect(subject).to permit(user1, column)
    end

    it 'allows manager to see a column' do
      expect(subject).to permit(user2, column)
    end

    it 'allows developer to see a column' do
      expect(subject).to permit(user3, column)
    end
  end

  permissions :update? do
    it 'allows admin to update and edit all columns' do
      expect(subject).to permit(user1, column)
    end

    it 'allows manager to update and edit a column' do
      expect(subject).to permit(user2, column)
    end

    it 'does not allow developer to update or edit a column' do
      expect(subject).not_to permit(user3, column)
    end
  end

  permissions :create? do
    it 'allows admin to create a column' do
      expect(subject).to permit(user1, column)
    end

    it 'allows manager to create a column' do
      expect(subject).not_to permit(user2, column)
    end

    it "doesn't allow developer to create a column" do
      expect(subject).to_not permit(user3, column)
    end
  end

  permissions :destroy? do
    it 'allows admin to destroy a column' do
      expect(subject).to permit(user1, column)
    end

    it "doesn't allow manager to destroy a column" do
      expect(subject).to_not permit(user2, column)
    end

    it "doesn't allow developer to destroy a column" do
      expect(subject).to_not permit(user3, column)
    end
  end
end
