require 'test_helper'

class RecettesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recette = recettes(:one)
  end

  test "should get index" do
    get recettes_url
    assert_response :success
  end

  test "should get new" do
    get new_recette_url
    assert_response :success
  end

  test "should create recette" do
    assert_difference('Recette.count') do
      post recettes_url, params: { recette: { equipement_id: @recette.equipement_id, etiquette: @recette.etiquette, ligne_id: @recette.ligne_id, localisation_id: @recette.localisation_id, snmp: @recette.snmp, supervision: @recette.supervision, tacacs: @recette.tacacs, testdebit: @recette.testdebit, user_id: @recette.user_id } }
    end

    assert_redirected_to recette_url(Recette.last)
  end

  test "should show recette" do
    get recette_url(@recette)
    assert_response :success
  end

  test "should get edit" do
    get edit_recette_url(@recette)
    assert_response :success
  end

  test "should update recette" do
    patch recette_url(@recette), params: { recette: { equipement_id: @recette.equipement_id, etiquette: @recette.etiquette, ligne_id: @recette.ligne_id, localisation_id: @recette.localisation_id, snmp: @recette.snmp, supervision: @recette.supervision, tacacs: @recette.tacacs, testdebit: @recette.testdebit, user_id: @recette.user_id } }
    assert_redirected_to recette_url(@recette)
  end

  test "should destroy recette" do
    assert_difference('Recette.count', -1) do
      delete recette_url(@recette)
    end

    assert_redirected_to recettes_url
  end
end
