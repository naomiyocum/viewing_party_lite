# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieFacade do
  describe 'class methods', :vcr do
    describe '.top_rated' do
      it 'returns the top rated movis' do
        expect(described_class.top_rated[0].title).to eq('The Godfather')
      end
    end

    describe '.searched_movies' do
      it 'returns movies with the select word in its title' do
        expect(described_class.searched_movies('princess').first.title).to eq('Super Mario Brothers: Great Mission to Rescue Princess Peach')
      end
    end

    describe '.movie_by_id' do
      it 'returns details for the select movie by id' do
        expect(described_class.movie_by_id(550).title).to eq('Fight Club')
      end
    end

    describe '.cast' do
      it 'returns details for the select movie by id' do
        expect(described_class.cast(550)[0]).to eq('Edward Norton as The Narrator')
      end
    end

    describe '.reviews' do
      it 'returns details for the select movie by id' do
        test_string = 'Goddard: Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.'
        expect(described_class.reviews(550).first).to eq(test_string)
      end
    end
  end
end
