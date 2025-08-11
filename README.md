# Google-Map-Api-Key-Tester-

# Google Maps API Key Tester

A Bash tool for **bug bounty hunters, penetration testers, and developers** to quickly identify **exposed or valid Google Maps API keys** and detect which Google Maps Platform services are enabled.

---

## 🚀 Features
- **Single key or bulk testing** from a file  
- **Automatic API key extraction** using regex (`AIza...`)  
- Tests multiple Google Maps API services:
  - Places Search (Text / Nearby / Details / Autocomplete)
  - Geocoding / Reverse Geocoding
  - Directions API
  - Distance Matrix API
  - Time Zone API
  - Elevation API
  - Static Maps API
  - Street View API
- Color-coded results:  
  - ✅ **[ENABLED]** Service works with the key  
  - ❌ **[DISABLED]** Service blocked / restricted  
- Final **VALID / INVALID** key summary

---

## 📦 Installation
```bash
git clone https://github.com/yourusername/google-maps-api-key-tester.git
cd google-maps-api-key-tester
chmod +x google_maps_key_tester.sh
```

---

## 💻 Usage
```bash
# Test a single key
./google_maps_key_tester.sh AIzaXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# Test multiple keys from a file
./google_maps_key_tester.sh keys.txt
```
> `keys.txt` can contain raw API keys or full source files — the script automatically extracts keys.

---

## 📄 Example Output
```
===============================
Testing API Key: AIzaSyD-ExampleKey123
===============================
  [ENABLED] Geocoding → OK | Preview: {"results":[{"address_components":[{"long_name":"New York"...
  [DISABLED] StaticMap → REQUEST_DENIED
  [ENABLED] PlacesNearby → ZERO_RESULTS | Preview: {"results":[],"status":"ZERO_RESULTS"}

[VALID KEY] AIzaSyD-ExampleKey123
```

---

## 🛠 Requirements
- **Bash 4.0+** (macOS users: install via Homebrew)
- `curl`

---

## ⚠ Disclaimer
This script is provided **for educational and security testing purposes only**.  
Do not use it on systems you do not own or have explicit permission to test.  
The author is not responsible for misuse or any resulting consequences.

---

## 📜 License
[MIT License](LICENSE)
