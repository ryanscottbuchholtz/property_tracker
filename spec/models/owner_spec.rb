require 'spec_helper'

describe Owner do
  describe 'validations' do
    let(:owner) { FactoryGirl.build(:owner)}
    let(:blank) { ['', nil] }

    it 'is valid when it has all required and valid attributes' do
      expect(owner).to be_valid
    end

    it { should_not have_valid(:first_name).when(*blank) }
    it { should_not have_valid(:last_name).when(*blank) }
    it { should_not have_valid(:email_address).when(*blank, 'ryan.com', 'ryan@com', 'ryan@.com') }
    it { should have_valid(:company).when(*blank) }
  
  end

end