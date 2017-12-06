require 'test_helper'

class EquipementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipement = equipements(:one)
  end

  test "should get index" do
    get equipements_url
    assert_response :success
  end

  test "should get new" do
    get new_equipement_url
    assert_response :success
  end

  test "should create equipement" do
    assert_difference('Equipement.count') do
      post equipements_url, params: { equipement: { achat: @equipement.achat, asapid: @equipement.asapid, dns: @equipement.dns, garantie: @equipement.garantie, iosv: @equipement.iosv, ip: @equipement.ip, marque: @equipement.marque, modele: @equipement.modele, nom: @equipement.nom, serial: @equipement.serial, snmpcontact: @equipement.snmpcontact } }
    end

    assert_redirected_to equipement_url(Equipement.last)
  end

  test "should show equipement" do
    get equipement_url(@equipement)
    assert_response :success
  end

  test "should get edit" do
    get edit_equipement_url(@equipement)
    assert_response :success
  end

  test "should update equipement" do
    patch equipement_url(@equipement), params: { equipement: { achat: @equipement.achat, asapid: @equipement.asapid, dns: @equipement.dns, garantie: @equipement.garantie, iosv: @equipement.iosv, ip: @equipement.ip, marque: @equipement.marque, modele: @equipement.modele, nom: @equipement.nom, serial: @equipement.serial, snmpcontact: @equipement.snmpcontact } }
    assert_redirected_to equipement_url(@equipement)
  end

  test "should destroy equipement" do
    assert_difference('Equipement.count', -1) do
      delete equipement_url(@equipement)
    end

    assert_redirected_to equipements_url
  end
end
