require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
    i = 1
    20.times do 
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
      i+=1
    end 
  end 

  it 'shows all movies' do 
    @current_user = User.find(@user1.id)

    visit login_path
    fill_in :email, with: @current_user.email
    fill_in :password, with: "password"
    click_on "Log In"

    click_button "Find Top Rated Movies"

    expect(current_path).to eq("/users/#{@user1.id}/movies")

    expect(page).to have_content("Top Rated Movies")
    
    movie_1 = Movie.first

    click_link(movie_1.title)

    expect(current_path).to eq("/users/#{@user1.id}/movies/#{movie_1.id}")

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.description)
    expect(page).to have_content(movie_1.rating)
  end 

  it 'does not allow visitors to create viewing party while logged out' do 
    user_id = @user1.id
    movie_id = Movie.first.id

    visit "/users/#{user_id}/movies/#{movie_id}"

    click_button "Create Viewing Party for Movie"

    expect(current_path).to eq(login_path)
  end
end