# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New View Party Page', type: :feature do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:user_3) { create(:user) }

  let!(:movie_1) do
    Movie.new(id: 550, title: 'Fight Club', vote_average: 5.3, overview: 'hahaha', runtime: 330, genres: 'romance')
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit new_movie_view_party_path(movie_1.id)
  end

  describe 'When I visit the new viewing party page', :vcr do
    it 'I should see the name of the movie title rendered above a form and a button to the discover page' do
      within '#header' do
        expect(page).to have_content("Create a Movie Party for #{movie_1.title}")
        click_button 'Discover Page'
      end

      expect(page).to have_current_path('/discover', ignore_query: true)
    end

    it 'the form should include the following fields: name, duration, when, start time, checkboxes next to each existing user in the system, after submitting I should be taken back to my dashboard where I see the new event' do
      within '#form' do
        fill_in :duration, with: 400
        fill_in :datetime, with: '2030-02-02 01:00:00 UTC '
        click_button 'Create Party'
      end

      expect(page).to have_current_path(dashboard_path, ignore_query: true)

      recent_view_party = ViewParty.last
      within "##{recent_view_party.movie_id}" do
        expect(page).to have_content(recent_view_party.movie_name)
        expect(page).to have_content(recent_view_party.datetime.strftime('%A, %d %B %Y'))
        expect(page).to have_content('Hosting')
      end
    end

    it 'if fields are filled out incorrectly the user will be redirected to the same page and see error messages' do
      within '#form' do
        fill_in :duration, with: 200
        fill_in :datetime, with: '2019-02-02 01:00:00 UTC '
        click_button 'Create Party'
      end

      expect(page).to have_current_path(new_movie_view_party_path(movie_1.id), ignore_query: true)
      expect(page).to have_content('Datetime cannot be in the past')
    end

    it 'the duration in the form cannot be set to a value less than the duration of the movie' do
      within '#form' do
        fill_in :duration, with: 1
        fill_in :datetime, with: '2023-02-02 01:00:00 UTC '
        check "invite_users_#{user_2.id}"
        click_button 'Create Party'
      end

      expect(page).to have_current_path(new_movie_view_party_path(movie_1.id), ignore_query: true)
      expect(page).to have_content('Party duration cannot be shorter than the movie duration')
    end

    it 'the new view party should also show on dashboards of users that were invited' do
      within '#form' do
        fill_in :duration, with: 400
        fill_in :datetime, with: DateTime.now + 10.days
        check "invite_users_#{user_2.id}"
        click_button 'Create Party'
      end

      recent_view_party = ViewParty.last

      VCR.eject_cassette
      VCR.eject_cassette
      VCR.eject_cassette

      VCR.insert_cassette 'view party'
      VCR.insert_cassette 'movie show'
      VCR.insert_cassette 'image url'

      visit dashboard_path

      within "##{recent_view_party.movie_id}" do
        expect(page).to have_content(recent_view_party.movie_name)
        expect(page).to have_content(recent_view_party.datetime.strftime('%A, %d %B %Y'))
      end
    end
  end
end
