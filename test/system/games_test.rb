require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end
  test "Submitting a random word raises an error" do
    visit new_url
    fill_in "word", with: "Mypineapplehurts!"
    click_on "Submit!"

    assert_text "Mypineapplehurts! can't be made with those letters."
  end
  test "Submitting a one letter consonant shows invalid word" do
    visit new_url
    p all(:css, "li")[0].text(:all)
    fill_in "word", with: "b"

    click_on "Submit!"

    p URI.parse(current_url).query

    assert_text "b is not a valid word!"
  end
end
