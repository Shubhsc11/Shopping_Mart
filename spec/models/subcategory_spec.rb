# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:subcategory_name) }
    # it { should validate_uniqueness_of(:subcategory_name) }
  end

  describe 'associations' do
    it { should belong_to(:category).class_name('Category') }
    it { should have_many(:products).class_name('Product').dependent(:destroy) }
  end
end
