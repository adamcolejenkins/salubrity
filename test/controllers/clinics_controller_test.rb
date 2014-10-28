require 'test_helper'

class ClinicsControllerTest < ActionController::TestCase
  setup do
    @clinic = clinics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clinics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clinic" do
    assert_difference('Clinic.count') do
      post :create, clinic: { address2: @clinic.address2, address: @clinic.address, city: @clinic.city, guid: @clinic.guid, phone: @clinic.phone, state: @clinic.state, survey_id: @clinic.survey_id, title: @clinic.title, zip: @clinic.zip }
    end

    assert_redirected_to clinic_path(assigns(:clinic))
  end

  test "should show clinic" do
    get :show, id: @clinic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clinic
    assert_response :success
  end

  test "should update clinic" do
    patch :update, id: @clinic, clinic: { address2: @clinic.address2, address: @clinic.address, city: @clinic.city, guid: @clinic.guid, phone: @clinic.phone, state: @clinic.state, survey_id: @clinic.survey_id, title: @clinic.title, zip: @clinic.zip }
    assert_redirected_to clinic_path(assigns(:clinic))
  end

  test "should destroy clinic" do
    assert_difference('Clinic.count', -1) do
      delete :destroy, id: @clinic
    end

    assert_redirected_to clinics_path
  end
end
