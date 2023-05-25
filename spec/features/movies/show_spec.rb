# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'The Movie Show Page', type: :feature do
  let!(:user_1) { create(:user) }

  before do
    visit login_path
    fill_in :email, with: user_1.email
    fill_in :password, with: user_1.password
    click_button 'Log In'
    visit '/movies/550'
  end

  describe 'When I visit the user movie path', :vcr do
    it 'I see a button to return to the "Discover Page"' do
      expect(page).to have_button('Discover Page')
    end

    describe 'When I click on "Discover Page' do
      it 'I am taken to the movies discover page' do
        click_button('Discover Page')
        expect(page).to have_current_path('/discover', ignore_query: true)
      end
    end

    it "I see a button to 'Create Viewing Party for Fight Club" do
      expect(page).to have_button('Create Viewing Party for Fight Club')
    end

    describe 'When I click on "Create Viewing Party for Fight Club', :vcr do
      it 'I am taken to new_user_movie_viewing_party' do
        click_button('Create Viewing Party for Fight Club')
        expect(page).to have_current_path(new_movie_view_party_path(550), ignore_query: true)
      end
    end

    describe "I see the Movie's..." do
      it 'Title, Vote Average, Runtime, and Genres' do
        expect(page).to have_content('Fight Club')
        expect(page).to have_content('Vote: 8.4')
        expect(page).to have_content('Runtime: 2hr 19min')
        expect(page).to have_content('Genre: Drama, Thriller, Comedy')
      end

      it 'Summery' do
        expect(page).to have_content('A ticking-time-bomb insomniac')
      end

      it 'Top 10 cast members' do
        expect(page).to have_content('Edward Norton as The Narrator')
        expect(page).to have_content('David Andrews as Thomas')
      end

      it 'Count of reviews' do
        expect(page).to have_content('8 Reviews:')
      end

      it 'Each reviews author and info' do
        expect(page).to have_content('Goddard: Pretty awesome movie.')
        expect(page).to have_content('katch22: Madness unbounded.')
      end
    end
  end
end
