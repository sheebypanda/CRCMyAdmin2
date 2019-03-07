Geocoder.configure(
  :http_proxy => 'http://s-proxc.mbx.fr:80',
  :https_proxy => 'https://s-proxc.mbx.fr:80',
  :timeout => 5,
  lookup: :nominatim,
  units: :km,
  :http_headers => { "User-Agent" => "acassol@bordeaux-metropole.fr" }
)
