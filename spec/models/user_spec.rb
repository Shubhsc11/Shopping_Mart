# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:products).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:delivery_details).dependent(:destroy) }
  end

  describe 'enums' do
    it {
      should define_enum_for(:roles).with_values(owner: 'owner', customer: 'customer').backed_by_column_of_type(:string)
    }
  end

  describe 'callbacks' do
    it 'sets default credit points for customer after create' do
      user = User.create(email: 'customer@example.com', password: 'password', roles: 'customer')
      expect(user.points).to eq(5000)
    end

    it 'does not set credit points for owner after create' do
      user = User.create(email: 'owner@example.com', password: 'password', roles: 'owner')
      expect(user.points).to be_nil
    end
  end
end
