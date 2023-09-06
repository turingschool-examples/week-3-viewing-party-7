require 'rails_helper'

RSpec.describe "Login Form" do
  before do
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
  end

  it "has fields for email and password and a submit button" do
    visit login_path

    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    expect(page).to have_button("Submit")
  end

  describe "successful login" do
    it "routes to user dashboard when good credentials are submitted" do
      visit login_path

      fill_in :email, with:'user1@test.com'
      fill_in :password, with: 'password123'
      click_button "Submit"

      expect(current_path).to eq(user_path(@user1.id))
    end
  end
end