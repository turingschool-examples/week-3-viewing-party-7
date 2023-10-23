require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name, unique email, password, and password confirmation' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "1234"
    fill_in :user_password_confirmation, with: "1234"
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "1234")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it "I'm redirected back to the /register page if I don't fill in the name field" do
    visit register_path

    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "1234"
    fill_in :user_password_confirmation, with: "1234"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end
  
  it "I'm redirected back to the /register page if I don't fill in the email field" do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_password, with: "1234"
    fill_in :user_password_confirmation, with: "1234"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end

  it "I'm redirected back to the /register page if I don't fill in the password field" do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password_confirmation, with: "1234"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password can't be blank")
  end
  
  it "I'm redirected back to the /register page if I don't fill in the password confirmation field/password confirmation field is different" do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "1234"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "1234"
    fill_in :user_password_confirmation, with: "5678"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
