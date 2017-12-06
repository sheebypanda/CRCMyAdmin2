require 'test_helper'

class LignesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ligne = lignes(:one)
  end

  test "should get index" do
    get lignes_url
    assert_response :success
  end

  test "should get new" do
    get new_ligne_url
    assert_response :success
  end

  test "should create ligne" do
    assert_difference('Ligne.count') do
      post lignes_url, params: { ligne: { compte: @ligne.compte, debit: @ligne.debit, identifiantoperateur: @ligne.identifiantoperateur, ippublique: @ligne.ippublique, mail: @ligne.mail, mdpoperateur: @ligne.mdpoperateur, motdepasse: @ligne.motdepasse, ndi: @ligne.ndi, numerocompte: @ligne.numerocompte, operateur_id: @ligne.operateur_id, tel: @ligne.tel } }
    end

    assert_redirected_to ligne_url(Ligne.last)
  end

  test "should show ligne" do
    get ligne_url(@ligne)
    assert_response :success
  end

  test "should get edit" do
    get edit_ligne_url(@ligne)
    assert_response :success
  end

  test "should update ligne" do
    patch ligne_url(@ligne), params: { ligne: { compte: @ligne.compte, debit: @ligne.debit, identifiantoperateur: @ligne.identifiantoperateur, ippublique: @ligne.ippublique, mail: @ligne.mail, mdpoperateur: @ligne.mdpoperateur, motdepasse: @ligne.motdepasse, ndi: @ligne.ndi, numerocompte: @ligne.numerocompte, operateur_id: @ligne.operateur_id, tel: @ligne.tel } }
    assert_redirected_to ligne_url(@ligne)
  end

  test "should destroy ligne" do
    assert_difference('Ligne.count', -1) do
      delete ligne_url(@ligne)
    end

    assert_redirected_to lignes_url
  end
end
