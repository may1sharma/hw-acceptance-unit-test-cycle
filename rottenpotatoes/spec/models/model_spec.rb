require 'rails_helper'

describe Movie do
  describe '.find_similar_movies' do
    let!(:movie1) { FactoryGirl.create(:movie, title: 'Venom', director: 'Ruben Fleischer') }
    let!(:movie2) { FactoryGirl.create(:movie, title: 'Zombieland', director: 'Ruben Fleischer') }
    let!(:movie3) { FactoryGirl.create(:movie, title: "Schindler's List", director: 'Steven Spielberg') }
    let!(:movie4) { FactoryGirl.create(:movie, title: "Jurassic Park") }

    context 'director exists' do
      it 'finds similar movies correctly' do
        expect(Movie.similar_movies(movie1.title)).to eql(['Venom', "Zombieland"])
        expect(Movie.similar_movies(movie1.title)).to_not include(["Schindler's List"])
        expect(Movie.similar_movies(movie3.title)).to eql(["Schindler's List"])
      end
    end

    context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.similar_movies(movie4.title)).to eql(nil)
      end
    end
  end

  describe '.all_ratings' do
    it 'returns all ratings' do
      expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
    end
  end
end