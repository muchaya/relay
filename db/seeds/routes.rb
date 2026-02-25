one_way_routes = [
  { from: :harare, to: :bulawayo, distance_km: 438, minutes_by_bus: 360, minutes_by_rideshare: 315, tollgates: 5 },
  { from: :harare, to: :mutare, distance_km: 263, minutes_by_bus: 225, minutes_by_rideshare: 195, tollgates: 3 },
  { from: :harare, to: :masvingo, distance_km: 292, minutes_by_bus: 240, minutes_by_rideshare: 195, tollgates: 3 },
  { from: :harare, to: :gweru, distance_km: 274, minutes_by_bus: 225, minutes_by_rideshare: 180, tollgates: 3 },
  { from: :bulawayo, to: :gweru, distance_km: 164, minutes_by_bus: 135, minutes_by_rideshare: 120, tollgates: 2 },
  { from: :bulawayo, to: :victoria_falls, distance_km: 440, minutes_by_bus: 360, minutes_by_rideshare: 345, tollgates: 2 },
  { from: :harare, to: :kariba, distance_km: 365, minutes_by_bus: 360, minutes_by_rideshare: 300, tollgates: 2 },
  { from: :harare, to: :beitbridge, distance_km: 571, minutes_by_bus: 510, minutes_by_rideshare: 390, tollgates: 6 },
  { from: :masvingo, to: :beitbridge, distance_km: 200, minutes_by_bus: 210, minutes_by_rideshare: 165, tollgates: 3 },
  { from: :masvingo, to: :chiredzi, distance_km: 150, minutes_by_bus: 150, minutes_by_rideshare: 135, tollgates: 2 }
]

bi_directional_routes =
  one_way_routes.flat_map do |route|
    [
      route,
      route.merge(from: route[:to], to: route[:from])
    ]
  end

bi_directional_routes.each do |route|
  from_place_name = route[:from].to_s.titleize
  to_place_name = route[:to].to_s.titleize

  from_place = Place.find_by!(name: from_place_name)
  to_place= Place.find_by!(name: to_place_name)

  Route.find_or_create_by!(
    from_place_id: from_place.id,
    to_place_id: to_place.id,
    from_place_slug: from_place.slug,
    to_place_slug: to_place.slug,
    distance_km: route[:distance_km],
    minutes_by_bus: route[:minutes_by_bus],
    minutes_by_rideshare: route[:minutes_by_rideshare],
    tollgates: route[:tollgates],
    status: 'active'
  )
end
