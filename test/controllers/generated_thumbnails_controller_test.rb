require "test_helper"

class GeneratedThumbnailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @generated_thumbnail = generated_thumbnails(:one)
  end

  test "should get index" do
    get generated_thumbnails_url
    assert_response :success
  end

  test "should get new" do
    get new_generated_thumbnail_url
    assert_response :success
  end

  test "should create generated_thumbnail" do
    assert_difference("GeneratedThumbnail.count") do
      post generated_thumbnails_url, params: { generated_thumbnail: {} }
    end

    assert_redirected_to generated_thumbnail_url(GeneratedThumbnail.last)
  end

  test "should show generated_thumbnail" do
    get generated_thumbnail_url(@generated_thumbnail)
    assert_response :success
  end

  test "should get edit" do
    get edit_generated_thumbnail_url(@generated_thumbnail)
    assert_response :success
  end

  test "should update generated_thumbnail" do
    patch generated_thumbnail_url(@generated_thumbnail), params: { generated_thumbnail: {} }
    assert_redirected_to generated_thumbnail_url(@generated_thumbnail)
  end

  test "should destroy generated_thumbnail" do
    assert_difference("GeneratedThumbnail.count", -1) do
      delete generated_thumbnail_url(@generated_thumbnail)
    end

    assert_redirected_to generated_thumbnails_url
  end
end
