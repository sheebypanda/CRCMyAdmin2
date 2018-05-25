// document.addEventListener("turbolinks:load", function() {
//
//   $('[data-toggle="tooltip"]').tooltip();
//
//   function getLocation(){
//     var msg;
//     if('geolocation' in navigator){
//       requestLocation();
//     }else{
//       msg = "Sorry, looks like your browser doesn't support geolocation";
//       outputResult(msg); // output error message
//       $('.pure-button').removeClass('pure-button-primary').addClass('pure-button-success'); // change button style
//     }
//
//     function requestLocation(){
//
//       var options = {
//         enableHighAccuracy: false,
//         timeout: 5000,
//         maximumAge: 0
//       };
//
//       navigator.geolocation.getCurrentPosition(success, error, options);
//
//       function success(pos){
//         var lng = pos.coords.longitude;
//         var lat = pos.coords.latitude;
//         msg = 'You appear to be at longitude: ' + lng + ' and latitude: ' + lat  + '<img src="https://maps.googleapis.com/maps/api/staticmap?zoom=15&size=300x300&maptype=roadmap&markers=color:red%7Clabel:A%7C' + lat + ',' + lng+ '&sensor=false">';
//         outputResult(msg); // output message
//         $('.pure-button').removeClass('pure-button-primary').addClass('pure-button-success'); // change button style
//
//         $('#localisation_lat').val(lat);
//         $('#localisation_lng').val(lng);
//         $('#gps').addClass("active");
//
//
//       }
//
//       function error(err){
//         msg = 'Error: ' + err + ' :(';
//         outputResult(msg); // output button
//         $('.pure-button').removeClass('pure-button-primary').addClass('pure-button-error'); // change button style
//       }
//     } // end requestLocation();
//
//     function outputResult(msg){
//       $('.result').addClass('result').html(msg);
//     }
//   } // end getLocation()
//
//   // attach getLocation() to button click
//   $('#gps').on('click', function(){
//     // show spinner while getlocation() does its thing
//     $('.result').html('<i class="fa fa-spinner fa-spin"></i>');
//     getLocation();
//   });
//
// };

document.addEventListener("turbolinks:load", function() {

  $("#tablesorter").tablesorter();

  $(".recette_localisation_id").hide();

  $("#recette_localisation_ville").change(function() {
    var ville = $( this ).val();
    $(".recette_localisation_id").show();
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

})
