# encoding: utf-8

require "spec_helper"

describe "Competitions" do
  before do
    competition = WCA.new_competition name: "German Open 2013", date: Date.new(2013, 8, 23), location: "Gütersloh"
    competition.publish!
  end

  describe "competitions list" do
    before { visit "/competitions" }

    it "lists all competitions" do
      within("ol.competitions") do
        expect(page).to have_content("German Open 2013")
      end
    end
  end

  describe "creating competitions" do
    before do
      visit "/competitions/new"
      fill_in "Name", :with => "Hessen Open 2013"
      fill_in "Date", :with => "2013-07-10"
      fill_in "Days", :with => "4"
      fill_in "Location", :with => "Wiesbaden"
      click_button "Create Competition"
    end

    it "creates new competitions" do
      within("ol.competitions") do
        expect(page).to have_content("Hessen Open 2013")
      end
    end
  end


  describe "competition details" do

    before { visit "/competitions/german-open-2013" }

    it "shows competition name" do
      within("h1") { expect(page).to have_content("German Open 2013") }
    end

    it "shows date and venue" do
      expect(page).to have_content("August 23, 2013")
      expect(page).to have_content("Gütersloh")
    end
  end
end
