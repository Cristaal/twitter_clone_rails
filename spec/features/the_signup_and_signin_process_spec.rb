require 'rails_helper'

describe "the user login process" do
  it "logs the user in" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page). to have_content "Signed in successfully"
  end

  it 'returns an error if user doesnt exist' do
    visit root_path
    click_on "Login"
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: Faker::Internet.password(8)
    click_button "Log in"
    expect(page).to have_content "Invalid email or password"
  end

  it 'returns an error if no password is entered' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: ''
    click_button "Log in"
    expect(page).to have_content "Invalid email or password"
  end

  it 'returns an error if no email is entered' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "Login"
    fill_in "Email", :with => " "
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content "Invalid email or password"
  end

  it "logs the user out" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    click_on "Logout"
    expect(page).to have_content "Signed out successfully"
  end

end
