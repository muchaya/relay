# =====================
# Places
# =====================

places_data = {
  mutare: {
    name: "Mutare",
    locality: "City",
    province: "Manicaland",
    country: "Zimbabwe"
  },
  harare: {
    name: "Harare",
    locality: "Capital city",
    province: "Harare Metropolitan",
    country: "Zimbabwe"
  },
  bulawayo: {
    name: "Bulawayo",
    locality: "City",
    province: "Bulawayo",
    country: "Zimbabwe"
  },
  gweru: {
    name: "Gweru",
    locality: "City",
    province: "Midlands",
    country: "Zimbabwe"
  },
  kariba: {
    name: "Kariba",
    locality: "Town",
    province: "Mashonaland West",
    country: "Zimbabwe"
  },
  zvishavane: {
    name: "Zvishavane",
    locality: "Town",
    province: "Midlands",
    country: "Zimbabwe"
  },
  beitbridge: {
    name: "Beitbridge",
    locality: "Town",
    province: "Matabeleland South",
    country: "Zimbabwe"
  },
  masvingo: {
    name: "Masvingo",
    locality: "City",
    province: "Masvingo",
    country: "Zimbabwe"
  },
  chiredzi: {
    name: "Chiredzi",
    locality: "Town",
    province: "Masvingo",
    country: "Zimbabwe"
  },
  victoria_falls: {
    name: "Victoria Falls",
    locality: "Town",
    province: "Matabeleland North",
    country: "Zimbabwe"
  }
}

places = {}

places_data.each do |key, attrs|
  places[key] = Place.find_or_create_by!(name: attrs[:name]) do |p|
    p.locality = attrs[:locality]
    p.province = attrs[:province]
    p.country  = attrs[:country]
  end
end

puts "✅ Seeded #{places.size} places"

# =====================
# Routes
# =====================

routes_data = [
  [:harare, :bulawayo, 438],
  [:bulawayo, :harare, 438],

  [:harare, :mutare, 263],
  [:mutare, :harare, 263],

  [:harare, :masvingo, 292],
  [:masvingo, :harare, 292],

  [:harare, :gweru, 274],
  [:gweru, :harare, 274],

  [:bulawayo, :gweru, 164],
  [:gweru, :bulawayo, 164],

  [:bulawayo, :victoria_falls, 440],
  [:victoria_falls, :bulawayo, 440],

  [:harare, :kariba, 365],
  [:kariba, :harare, 365],

  [:harare, :beitbridge, 571],
  [:beitbridge, :harare, 571],

  [:masvingo, :beitbridge, 200],
  [:beitbridge, :masvingo, 200],

  [:masvingo, :chiredzi, 150],
  [:chiredzi, :masvingo, 150]
]

routes_data.each do |from_key, to_key, distance|
  Route.find_or_create_by!(
    from_place: places[from_key],
    to_place: places[to_key]
  ) do |r|
    r.distance_km = distance
    r.status = "active"
  end
end

puts "✅ Seeded #{routes_data.size} routes"
