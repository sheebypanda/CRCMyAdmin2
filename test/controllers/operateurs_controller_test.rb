require 'test_helper'

class OperateursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operateur = operateurs(:one)
  end

  test "should get index" do
    get operateurs_url
    assert_response :success
  end

  test "should get new" do
    get new_operateur_url
    assert_response :success
  end

  test "should create operateur" do
    assert_difference('Operateur.count') do
      post operateurs_url, params: { operateur: { hotline: @operateur.hotline, nom: @operateur.nom } }
    end

    assert_redirected_to operateur_url(Operateur.last)
  end

  test "should show operateur" do
    get operateur_url(@operateur)
    assert_response :success
  end

  test "should get edit" do
    get edit_operateur_url(@operateur)
    assert_response :success
  end

  test "should update operateur" do
    patch operateur_url(@operateur), params: { operateur: { hotline: @operateur.hotline, nom: @operateur.nom } }
    assert_redirected_to operateur_url(@operateur)
  end

  test "should destroy operateur" do
    assert_difference('Operateur.count', -1) do
      delete operateur_url(@operateur)
    end

    assert_redirected_to operateurs_url
  end
end
