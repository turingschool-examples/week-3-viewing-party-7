require 'rails_helper'

RSpec.describe 'Logging in' do
  context 'login form Happy Path' do
    scenario 'A user can login with correct credentials' do
      user = User.create(name: "Sean Suga", email: "champ4lyfe@gmail.com", password: "champ", password_confirmation: "champ")

      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Log In"

      expect(current_path).to eq(user_path(user))
    end
  end

  context 'login form Sad Path' do
    scenario 'A user cannot login with incorrect credentials' do
      user = User.create(name: "Sean Suga", email: "champ4lyfe@gmail.com", password: "champ", password_confirmation: "champ")

      visit root_path

      click_on "Log In"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: 'champion'
      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect credentials")
    end
  end
end
