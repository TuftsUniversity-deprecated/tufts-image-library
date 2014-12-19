require 'rails_helper'

feature 'User Impersonation:' do

  context 'as an admin user' do
    let(:admin) { FactoryGirl.create(:admin) }

    before do
      ActiveFedora::Base.delete_all
      sign_in(admin)
    end

    scenario 'i log in and try to impersonate another user' do

      visit root_path
      click_link('Impersonate')
      expect(page).to have_content('Search for a user to impersonate')

    end
  end

  context 'as a student' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      ActiveFedora::Base.delete_all
      sign_in(user)
    end

    scenario 'i log in and there is no impersonate link' do
      visit root_path
      expect(page).to_not have_link('Impersonate')
    end
  end
end
