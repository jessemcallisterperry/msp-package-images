require "application_system_test_case"

class GeneratedThumbnailsTest < ApplicationSystemTestCase
  setup do
    @generated_thumbnail = generated_thumbnails(:one)
  end

  test "visiting the index" do
    visit generated_thumbnails_url
    assert_selector "h1", text: "Generated thumbnails"
  end

  test "should create generated thumbnail" do
    visit generated_thumbnails_url
    click_on "New generated thumbnail"

    click_on "Create Generated thumbnail"

    assert_text "Generated thumbnail was successfully created"
    click_on "Back"
  end

  test "should update Generated thumbnail" do
    visit generated_thumbnail_url(@generated_thumbnail)
    click_on "Edit this generated thumbnail", match: :first

    click_on "Update Generated thumbnail"

    assert_text "Generated thumbnail was successfully updated"
    click_on "Back"
  end

  test "should destroy Generated thumbnail" do
    visit generated_thumbnail_url(@generated_thumbnail)
    click_on "Destroy this generated thumbnail", match: :first

    assert_text "Generated thumbnail was successfully destroyed"
  end
end
