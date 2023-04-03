require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:description) }
  end

  describe 'relationships' do
    it { should have_many(:viewing_parties) }
  end
end