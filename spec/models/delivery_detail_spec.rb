# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryDetail, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:orders).class_name('Order').dependent(:nullify) }

    it 'validates delivery details limit' do
      user = create(:user)
      5.times { create(:delivery_detail, user: user) }
      delivery_detail = build(:delivery_detail, user: user)

      expect(delivery_detail).not_to be_valid
      expect(delivery_detail.errors[:base]).to include('You can only have up to 5 delivery addresses.')
    end
  end
end
