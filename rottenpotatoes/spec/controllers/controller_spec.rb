require 'rails_helper'

describe MoviesController , :type => :controller do
  describe 'Search movies by the same director' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:similar_movies).with('The Amazing SpiderMan')
      get :search, { title: 'The Amazing SpiderMan' }
    end

    it 'should assign similar movies if director exists' do
      movies = ['Avengers Infinity War', 'Black Panther']
      Movie.stub(:similar_movies).with('Black Panther').and_return(movies)
      get :search, { title: 'Black Panther' }
      expect(assigns(:similar_movies)).to eql(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:similar_movies).with('Ready Player One').and_return(nil)
      get :search, { title: 'Ready Player One' }
      expect(response).to redirect_to(root_url)
    end
  end
end