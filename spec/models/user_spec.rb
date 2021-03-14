require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:publications).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
