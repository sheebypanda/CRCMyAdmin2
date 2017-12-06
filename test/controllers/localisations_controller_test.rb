require 'test_helper'

class LocalisationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @localisation = localisations(:one)
  end

  test "should get index" do
    get localisations_url
    assert_response :success
  end

  test "should get new" do
    get new_localisation_url
    assert_response :success
  end

  test "should create localisation" do
    assert_difference('Localisation.count') do
      post localisations_url, params: { localisation: { adresse: @localisation.adresse, codepostal: @localisation.codepostal, description: @localisation.description, etage: @localisation.etage, lat: @localisation.lat, lng: @localisation.lng, mail: @localisation.mail, nom: @localisation.nom, tel: @localisation.tel, ville: @localisation.ville } }
    end

    assert_redirected_to localisation_url(Localisation.last)
  end

  test "should show localisation" do
    get localisation_url(@localisation)
    assert_response :success
  end

  test "should get edit" do
    get edit_localisation_url(@localisation)
    assert_response :success
  end

  test "should update localisation" do
    patch localisation_url(@localisation), params: { localisation: { adresse: @localisation.adresse, codepostal: @localisation.codepostal, description: @localisation.description, etage: @localisation.etage, lat: @localisation.lat, lng: @localisation.lng, mail: @localisation.mail, nom: @localisation.nom, tel: @localisation.tel, ville: @localisation.ville } }
    assert_redirected_to localisation_url(@localisation)
  end

  test "should destroy localisation" do
    assert_difference('Localisation.count', -1) do
      delete localisation_url(@localisation)
    end

    assert_redirected_to localisations_url
  end
end
