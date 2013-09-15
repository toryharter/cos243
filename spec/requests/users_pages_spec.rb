require 'spec_helper'

describe "UsersPages" do
  describe "GET /users_pages" do
    it "has sign up on page" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/users/new'
      expect(page).to have_content('Sign up')
    end
    it "supports form filling out" do
      visit '/users/new'
      fill_in :username, with: 'username'
    end
  end
end


require 'spec_helper'
