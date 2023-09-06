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
end