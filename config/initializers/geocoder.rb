Geocoder.configure(
  :http_proxy => 'http://172.20.92.38:3128',
  :https_proxy => 'https://172.20.92.38:3128',
  :timeout => 5,
  lookup: :nominatim,
  units: :km,
  :http_headers => { "User-Agent" => "acassol@bordeaux-metropole.fr" }
)
