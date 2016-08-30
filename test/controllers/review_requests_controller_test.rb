require 'test_helper'

class ReviewRequestsControllerTest < ActionController::TestCase
  setup do
    @review_request = review_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:review_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create review_request" do
    assert_difference('ReviewRequest.count') do
      post :create, review_request: { product_id: @review_request.product_id, search_text: @review_request.search_text }
    end

    assert_redirected_to review_request_path(assigns(:review_request))
  end

  test "should show review_request" do
    get :show, id: @review_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @review_request
    assert_response :success
  end

  test "should update review_request" do
    patch :update, id: @review_request, review_request: { product_id: @review_request.product_id, search_text: @review_request.search_text }
    assert_redirected_to review_request_path(assigns(:review_request))
  end

  test "should destroy review_request" do
    assert_difference('ReviewRequest.count', -1) do
      delete :destroy, id: @review_request
    end

    assert_redirected_to review_requests_path
  end
end
