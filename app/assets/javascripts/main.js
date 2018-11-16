document.addEventListener("turbolinks:load", function() {

  $("#tablesorter").tablesorter();

  $("#recette_localisation_ville").change(function() {
    var ville = $( this ).val();
    $(".loc").hide();
    var option = "."
    option += ville.replace(/ /g,'')
    $(option).show();
  });

  $("#recette_localisation_id").change(function(){
    var localisation_id = $(this).val();
    $(".ligne").hide();
    var ligne_option = ".";
    ligne_option += localisation_id;
    $(ligne_option).show();
  });

  $(".text-filtre").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#filtre-select-loc select option").filter(function(){
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

  $(".ligne-filtre").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#filtre-select-lig select option").filter(function(){
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

  $("#filtre_equipements").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $(".equipement").filter(function(){
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

})
