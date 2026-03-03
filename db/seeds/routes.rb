one_way_routes = [
  { from: :harare, to: :bulawayo, distance_km: 438,  time_minutes: 315, tollgates: 5 },
  { from: :harare, to: :mutare, distance_km: 263, time_minutes: 195, tollgates: 3 },
  { from: :harare, to: :masvingo, distance_km: 292, time_minutes: 195, tollgates: 3 },
  { from: :harare, to: :gweru, distance_km: 274, time_minutes: 180, tollgates: 3 },
  { from: :bulawayo, to: :gweru, distance_km: 164,  time_minutes: 120, tollgates: 2 },
  { from: :bulawayo, to: :victoria_falls, distance_km: 360, time_minutes: 345, tollgates: 2 },
  { from: :harare, to: :kariba, distance_km: 365, time_minutes: 300, tollgates: 2 },
  { from: :harare, to: :beitbridge, distance_km: 571, time_minutes: 390, tollgates: 6 },
  { from: :masvingo, to: :beitbridge, distance_km: 200, time_minutes: 165, tollgates: 3 },
  { from: :masvingo, to: :chiredzi, distance_km: 150, time_minutes: 135, tollgates: 2 }
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
    time_minutes: route[:time_minutes],
    tollgates: route[:tollgates],
    status: 'active'
  )
end
