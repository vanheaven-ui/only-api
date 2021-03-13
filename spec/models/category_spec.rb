require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'associations' do
    it { should have_many(:publications) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_uniqueness_of(:name).case_sensitive }
  end
end
