require 'rails_helper'

RSpec.describe 'Registration' do
  context 'Authentication Happy Path' do
    scenario 'A visitor can register as a user with authentication' do
      visit register_path

      email = 'seansuga_135@gmail.com'
      password = 'champ'

      fill_in 'user[name]', with: 'Sean'
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_on 'Create New User'

      expect(current_path).to eq(user_path(User.last.id))
    end
  end

  context 'Authentication Sad Path' do
    scenario 'A visitor cannot register as a user with inncorrect authentication' do
      visit register_path

      email = 'seansuga_135@gmail.com'
      password = 'champ'

      fill_in 'user[name]', with: 'Sean'
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: 'champ4lyfe'
      click_on 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
