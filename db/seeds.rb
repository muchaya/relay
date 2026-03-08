def seed(file)
  load Rails.root.join("db", "seeds", "#{file}.rb")
  puts "Seeded #{file}"
end

def fake_phone_number = "+263#{%w[71 72 73 74 75 77 78].sample}#{rand(1_000_000..9_999_999)}"

def fake_identity_card_number = "#{%w[02 04 05 06 07 08 09 21 29 45 48 63 70].sample}-#{rand(100_000..999_999)}#{("A".."Z").to_a.sample}#{rand(10..99)}"

def fake_number_plate = "#{(1..3).map { ("A".."Z").to_a.sample }.join} #{rand(1000..9999)}"

def email_from(fullname) = "#{fullname.split.first.downcase}@example.com"

def find_or_create_user(fullname, gender)
  name = fullname.split.first.downcase

  user = User.find_or_create_by(fullname:, gender:) do |user|
    puts user.inspect
    user.email_address = email_from fullname
    user.phone_number = fake_phone_number
    user.identity_card_number = fake_identity_card_number
    user.password = "password"
    user.verified = [true, false].sample

    user.avatar.attach(
      io:       File.open(Rails.root.join("db/seeds/images/#{name}.jpg")),
      filename: "#{name}.jpg"
    )
  end
end

def find_or_create_vehicle(owner, model, vehicle_type, color)
  Vehicle.find_or_create_by!(number_plate: fake_number_plate) do |v|
    v.owner = owner
    v.model = model
    v.vehicle_type = vehicle_type
    v.color = color
  end
end


def create_trip!(driver:, route_slug:, date:, time:)
  from, to = route_slug.split("-")

  route = Route.find_by!(
    from_place_slug: from,
    to_place_slug: to
  )

  departs_at = Time.zone.parse("#{date} #{time}")

  Trip.find_or_create_by!(
    driver: driver,
    vehicle: driver.vehicles.first,
    route: route,
    departure_time: departs_at
  ) do |t|
    t.price     = ROUTES.fetch(route_slug).call
    t.seat_capacity  = 4
    t.women_only     = driver.gender == "female"
    t.luggage_policy = "small"
  end
end

puts "Seeding #{Rails.env} database..."
seed "places"
seed "routes"
seed "users"
seed "trips"
