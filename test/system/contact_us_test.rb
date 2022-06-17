require "application_system_test_case"

class ContactUsTest < ApplicationSystemTestCase
  setup do
    @contact_u = contact_us(:one)
  end

  test "visiting the index" do
    visit contact_us_url
    assert_selector "h1", text: "Contact Us"
  end

  test "creating a Contact us" do
    visit contact_us_url
    click_on "New Contact Us"

    click_on "Create Contact us"

    assert_text "Contact us was successfully created"
    click_on "Back"
  end

  test "updating a Contact us" do
    visit contact_us_url
    click_on "Edit", match: :first

    click_on "Update Contact us"

    assert_text "Contact us was successfully updated"
    click_on "Back"
  end

  test "destroying a Contact us" do
    visit contact_us_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contact us was successfully destroyed"
  end
end
