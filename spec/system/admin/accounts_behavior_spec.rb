require 'rails_helper'

describe "interaction for Admin::AccountsController", type: :feature do
  include HotGlue::ControllerHelper
  
    
  let!(:account1) {create(:account , name: FFaker::Movie.title, 
      is_admin: !!rand(2).floor, 
      email: FFaker::Movie.title )}
   

  describe "index" do
    it "should show me the list" do
      visit admin_accounts_path



    end
  end

  describe "new & create" do
    it "should create a new Account" do
      visit admin_accounts_path
      click_link "New Account"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Account")]')

      new_name = 'new_test-email@nowhere.com' 
      find("[name='account[name]']").fill_in(with: new_name)
     new_is_admin = rand(2).floor 
     find("[name='account[is_admin]'][value='#{new_is_admin}']").choose
      new_email = 'new_test-email@nowhere.com' 
      find("[name='account[email]']").fill_in(with: new_email)
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_name)
      expect(page).to have_content(new_is_admin)
      expect(page).to have_content(new_email)

    end
  end


  describe "edit & update" do
    it "should return an editable form" do
      visit admin_accounts_path
      find("a.edit-account-button[href='/admin/accounts/#{account1.id}/edit']").click

      expect(page).to have_content("Editing #{account1.name || "(no name)"}")
      new_name = FFaker::Lorem.paragraphs(1).join 
      find("input[name='account[name]']").fill_in(with: new_name)
     new_is_admin = rand(2).floor 
     find("[name='account[is_admin]'][value='#{new_is_admin}']").choose
      new_email = FFaker::Lorem.paragraphs(1).join 
      find("input[name='account[email]']").fill_in(with: new_email)
      click_button "Save"
      within("turbo-frame#account__#{account1.id} ") do


        expect(page).to have_content(new_name)
        expect(page).to have_content(new_email)

      end
    end
  end

  describe "destroy" do
    it "should destroy" do
      visit admin_accounts_path
      accept_alert do
        find("form[action='/admin/accounts/#{account1.id}'] > input.delete-account-button").click
      end
#      find("form[action='/admin/accounts/#{account1.id}'] > input.delete-account-button").click

      expect(page).to_not have_content(account1.name)
      expect(Account.where(id: account1.id).count).to eq(0)
    end
  end
end

