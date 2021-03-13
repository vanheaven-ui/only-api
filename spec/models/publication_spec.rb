require 'rails_helper'

RSpec.describe Publication, type: :model do
  context 'associations' do
    it { should belong_to(:category) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_length_of(:title).is_at_least(3) }
    it { should validate_length_of(:author).is_at_least(3) }
  end
end
