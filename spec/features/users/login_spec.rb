require 'rails_helper'

RSpec.describe 'User login/logout' do 
  it 'can log out a user' do 
    user2 = User.create!(name: "UserTwo", email: "UserTwo@gmail.com", password: "password", password_confirmation: "password")
    visit root_path
    
    click_on "Log In"
    expect(current_path).to eq(login_path)

    fill_in :email, with: user2.email
    fill_in :password, with: user2.password
    click_on "Log In"
    click_on "Home"
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Log Out")

    click_on "Log Out"
    expect(current_path).to eq(root_path)
  end

  describe 'login' do 
    #   As a registered user
# When I visit the landing page `/`
# I see a link for "Log In"
# When I click on "Log In"
# I'm taken to a Log In page ('/login') where I can input my unique email and password.
# When I enter my unique email and correct password 
# I'm taken to my dashboard page
  it 'has a link to login' do
    user3 = User.create!(name: "User One", email: "user3@test.com", password: "password", password_confirmation: "password")
    visit '/'

    expect(page).to have_link('Log In')
    click_link 'Log In'

    expect(current_path).to eq(login_path)

    fill_in :email, with: "user3@test.com"
    fill_in :password, with: "password"
    click_on 'Log In'
    
    # expect(current_path).to eq(user_path(user3.id))
    expect(current_path).to eq(dashboard_path)
  end

  it 'sad path: cannot visit dashboard while user is not logged in' do
    user = User.create!(name: "Rusty Shackleford", email: "Gribmeister@dalesdeadbug.net", password: "nobugsonme123", password_confirmation: "nobugsonme123")
    visit '/dashboard'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You must be logged in to view this page.")

    # fill_in :email, with: "Gribmeister@dalesdeadbug.net"
    # fill_in :password, with: "nobugsonme123"
    # click_on 'Log In'

    # expect(current_path).to eq(user_path(user.id))
    # #further testing to make sure conditional actually works
    # click_on "Home"
    # click_on "Gribmeister@dalesdeadbug.net"
    # expect(current_path).to eq(user_path(user.id))
  end
end

  describe 'Part 2: Authorization Challenge' do
    describe 'US_1, US_2, US_3' do 
      it 'does not display existing users to unregistered users' do
        visit '/'
        expect(page).to_not have_content('Existing Users:')
      end

      it 'does not display existing users emails as a link to registered users' do 
        user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
        visit '/'
        click_link 'Log In'
        fill_in :email, with: user1.email
        fill_in :password, with: user1.password
        click_on 'Log In'
        click_on 'Home'

        expect(page).to have_content(user1.email)
        expect(page).to_not have_link(user1.email)
      end

      it 'does not allow visitors to visit dashboard while logged out' do 
        visit '/'
        visit '/dashboard'
        expect(current_path).to eq(root_path)
        expect(page).to have_content('You must be logged in to view this page.')
      end

    end
  end
end