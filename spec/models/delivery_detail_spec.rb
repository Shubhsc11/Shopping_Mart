# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryDetail, type: :model do
  describe 'associations' do
    it { should belong_to(:order).class_name('Order') }
    it { should belong_to(:user).class_name('User') }
  end
end
