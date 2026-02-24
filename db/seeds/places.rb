places_data = {
  beitbridge: {
    name: "Beitbridge",
    locality: "Town",
    province: "Matabeleland South",
    country: "Zimbabwe"
  },
  bulawayo: {
    name: "Bulawayo",
    locality: "City",
    province: "Bulawayo",
    country: "Zimbabwe"
  },
  chiredzi: {
    name: "Chiredzi",
    locality: "Town",
    province: "Masvingo",
    country: "Zimbabwe"
  },
  gweru: {
    name: "Gweru",
    locality: "City",
    province: "Midlands",
    country: "Zimbabwe"
  },
  harare: {
    name: "Harare",
    locality: "Capital city",
    province: "Harare Metropolitan",
    country: "Zimbabwe"
  },
  kariba: {
    name: "Kariba",
    locality: "Town",
    province: "Mashonaland West",
    country: "Zimbabwe"
  },
  masvingo: {
    name: "Masvingo",
    locality: "City",
    province: "Masvingo",
    country: "Zimbabwe"
  },
  mutare: {
    name: "Mutare",
    locality: "City",
    province: "Manicaland",
    country: "Zimbabwe"
  },
  victoria_falls: {
    name: "Victoria Falls",
    locality: "Town",
    province: "Matabeleland North",
    country: "Zimbabwe"
  },
  zvishavane: {
    name: "Zvishavane",
    locality: "Town",
    province: "Midlands",
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
