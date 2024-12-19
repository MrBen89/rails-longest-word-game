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
    first_letter = find(:css, "#letters", visible: false).value.gsub(/[AEIOU]/, '')[0]
    fill_in "word", with: first_letter
    click_on "Submit!"
    assert_text "#{first_letter} is not a valid word!"
  end
  test "Submitting a valid word gives a score" do
    visit new_url
    field = find(:css, "#letters", visible: false)
    execute_script("arguments[0].value = 'ABCDEFGHIJ'", field)
    fill_in "word", with: "bad"
    click_on "Submit!"
    assert_text "bad is worth 9 points. Your total score is 9"
  end
end
