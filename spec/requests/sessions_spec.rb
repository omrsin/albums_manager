require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  
  describe "GET /login" do
    it "works! (now write some real specs)" do
      visit login_path
      expect(page).to have_http_status(200)
    end
  end
end
