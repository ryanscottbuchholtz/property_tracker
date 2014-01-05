require 'spec_helper'

describe State do
  describe 'validations' do
    let(:state) { FactoryGirl.build(:state)}
    let(:blank) { ['', nil] }

    it 'is valid when it has all required and valid attributes' do
      expect(state).to be_valid
    end

    it { should_not have_valid(:name).when(*blank) }
  
  end

  describe 'associations' do
    it { should have_many(:buildings) }
  
  end

end
