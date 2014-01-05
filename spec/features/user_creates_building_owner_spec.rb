require 'spec_helper'

describe 'a real estate associate records a new property owner', %q{
  As a real estate associate
  I want to record a building owner
  So that I can keep track of our relationships with owners
} do

  # ACCEPTANCE CRITERIA
  # * I must specify a first name, last name, and e-mail address
  # * I can optionally specify a company name
  # * If I do not specify the required information, I am presented with errors
  # * If I specify the required information, the owner is recorded and I am redirected to enter another new owner

  context 'required information is provided (happy path)' do
    it 'creates a new building owner' do
      owner = FactoryGirl.create(:owner)

      visit new_owner_path
            
      fill_in 'First Name', with: owner.first_name
      fill_in 'Last Name', with: owner.last_name
      fill_in 'E-mail Address', with: owner.email_address
    
      click_on 'Add this Owner'

      expect(page).to have_content 'Owner added!'
      expect(page).to have_content 'Add new Owner'

      end
    end

  context 'missing information is provided' do
    it 'throws errors when required information is not provided' do

      visit new_owner_path

      click_on 'Add this Owner'

      expect(page).to_not have_content 'Owner added!'

    end
  end

  context 'invalid information is provided' do
    it 'throws an error when invalid e-mail address is provided' do
      owner = FactoryGirl.create(:owner)
      
      visit new_owner_path

      fill_in 'First Name', with: owner.first_name
      fill_in 'Last Name', with: owner.last_name
      fill_in 'E-mail Address', with: 'Ryan@gmail'

      click_on 'Add this Owner'

      expect(page).to have_content 'Invalid E-mail address.  Please try again.'
      expect(page).to_not have_content 'Owner added!'
    end

    it 'throws an error when invalid e-mail address is provided' do
      owner = FactoryGirl.create(:owner)
      
      visit new_owner_path

      fill_in 'First Name', with: owner.first_name
      fill_in 'Last Name', with: owner.last_name
      fill_in 'E-mail Address', with: 'Ryan.gmail.com'

      click_on 'Add this Owner'

      expect(page).to have_content 'Invalid E-mail address.  Please try again.'
      expect(page).to_not have_content 'Owner added!'

    end
  end

end