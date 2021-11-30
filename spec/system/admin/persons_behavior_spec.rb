require 'rails_helper'

describe "interaction for Admin::PersonsController", type: :feature do
  include HotGlue::ControllerHelper
  
    
  let!(:person1) {create(:person, account: account , name: FFaker::Movie.title )}
    let(:account) {create(:account  )}
 

  describe "index" do
    it "should show me the list" do
      visit admin_account_persons_path

    end
  end

  describe "new & create" do
    it "should create a new Person" do
      visit admin_account_persons_path
      click_link "New Person"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Person")]')

      new_name = 'new_test-email@nowhere.com' 
      find("[name='person[name]']").fill_in(with: new_name)
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_name)

    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit admin_account_persons_path
      find("a.edit-person-button[href='/admin/persons/#{person1.id}/edit']").click

      expect(page).to have_content("Editing #{person1.name || "(no name)"}")
      new_name = FFaker::Lorem.paragraphs(1).join 
      find("input[name='person[name]']").fill_in(with: new_name)
      click_button "Save"
      within("turbo-frame#person__#{person1.id} ") do


        expect(page).to have_content(new_name)

      end
    end
  end

  describe "destroy" do
    it "should destroy" do
      visit admin_account_persons_path
      accept_alert do
        find("form[action='/admin/persons/#{person1.id}'] > input.delete-person-button").click
      end
#      find("form[action='/admin/persons/#{person1.id}'] > input.delete-person-button").click

      expect(page).to_not have_content(person1.name)
      expect(Person.where(id: person1.id).count).to eq(0)
    end
  end
end

