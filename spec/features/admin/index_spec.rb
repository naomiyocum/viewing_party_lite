# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  let!(:user_1) { create(:user, role: 1) }
  let!(:user_2) { create(:user, role: 1) }
  let!(:user_3) { create(:user) }
  let!(:user_4) { create(:user) }

  describe 'When I visit the admin dashboard' do
    it 'as an admin, I see a list of all default users email addresses' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit admin_dashboard_path

      within '#existing-users' do
        expect(page).to have_content(user_3.email)
        expect(page).to have_content(user_4.email)
        expect(page).to_not have_content(user_2.email)

        click_link user_3.email
      end

      expect(current_path).to eq(admin_path(user_3))
    end

    it 'as a visitor, I am redirected to the landing page where I see an error message' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_3)

      visit admin_dashboard_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You must be admin to access the previous page')
    end
  end
end
