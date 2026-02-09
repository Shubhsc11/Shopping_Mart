# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:category_name) }
    # it { should validate_uniqueness_of(:category_name) }
  end

  describe 'associations' do
    it { should have_many(:products).class_name('Product').dependent(:destroy) }
    it { should have_many(:subcategories).class_name('Subcategory').dependent(:destroy) }
  end
end
