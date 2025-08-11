#!/opt/homebrew/bin/bash

# Google Maps API Key Tester
# Supports:
#   ./google_maps_key_tester.sh API_KEY
#   ./google_maps_key_tester.sh file.txt

test_key() {
  local KEY="$1"
  echo -e "\n==============================="
  echo "Testing API Key: $KEY"
  echo "==============================="

  # List of endpoints: "Name|URL"
  endpoints=$(cat <<EOF
PlacesATM|https://maps.googleapis.com/maps/api/place/textsearch/json?query=atm+near+melbourne&key=$KEY
Geocoding|https://maps.googleapis.com/maps/api/geocode/json?address=New+York&key=$KEY
ReverseGeocoding|https://maps.googleapis.com/maps/api/geocode/json?latlng=40.7128,-74.0060&key=$KEY
PlacesNearby|https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.7128,-74.0060&radius=500&type=restaurant&key=$KEY
PlacesTextSearch|https://maps.googleapis.com/maps/api/place/textsearch/json?query=pizza+in+New+York&key=$KEY
PlacesDetails|https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJOwg_06VPwokRYv534QaPC8g&key=$KEY
Directions|https://maps.googleapis.com/maps/api/directions/json?origin=New+York,NY&destination=Boston,MA&key=$KEY
DistanceMatrix|https://maps.googleapis.com/maps/api/distancematrix/json?origins=New+York,NY&destinations=Boston,MA&key=$KEY
TimeZone|https://maps.googleapis.com/maps/api/timezone/json?location=40.7128,-74.0060&timestamp=1458000000&key=$KEY
Elevation|https://maps.googleapis.com/maps/api/elevation/json?locations=40.714728,-73.998672&key=$KEY
StaticMap|https://maps.googleapis.com/maps/api/staticmap?center=New+York,NY&zoom=13&size=600x300&maptype=roadmap&key=$KEY
StreetView|https://maps.googleapis.com/maps/api/streetview?size=600x300&location=40.720032,-73.988354&heading=151.78&pitch=-0.76&key=$KEY
Autocomplete|https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Empire%20State&key=$KEY
EOF
)

  local valid=false

  while IFS='|' read -r name url; do
    RESPONSE=$(curl -s "$url")
    STATUS=$(echo "$RESPONSE" | sed -nE 's/.*"status"[[:space:]]*:[[:space:]]*"([^"]+)".*/\1/p' | head -n1)

    if [[ "$STATUS" == "OK" ]] || [[ "$STATUS" == "ZERO_RESULTS" ]]; then
      valid=true
      RESULT_PREVIEW=$(echo "$RESPONSE" | tr -d '\n' | cut -c1-80)
      echo -e "  [\e[32mENABLED\e[0m] $name → $STATUS | Preview: $RESULT_PREVIEW..."
    else
      echo -e "  [\e[31mDISABLED\e[0m] $name → $STATUS"
    fi
  done <<< "$endpoints"

  if $valid; then
    echo -e "\n[\e[32mVALID KEY\e[0m] $KEY"
  else
    echo -e "\n[\e[31mINVALID KEY\e[0m] $KEY"
  fi
}

# Main
if [[ -f "$1" ]]; then
  grep -Eo 'AIza[0-9A-Za-z_\-]{35}' "$1" | sort -u | while read -r KEY; do
    test_key "$KEY"
  done
elif [[ "$1" =~ ^AIza[0-9A-Za-z_\-]{35}$ ]]; then
  test_key "$1"
else
  echo "Usage:"
  echo "  $0 API_KEY"
  echo "  $0 file.txt"
  exit 1
fi
