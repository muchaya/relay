
DRIVER_EMAILS = %w[
  tendai@example.com
  craig@example.com
  rudo@example.com
  nkosana@example.com
  sithembile@example.com
].freeze

ROUTES = {
  "harare-mutare"   => -> { rand(8..12) },
  "harare-bulawayo" => -> { rand(15..25) }
}.freeze

TIMES = %w[06:00 09:00 13:00 17:30 18:00 19:30].freeze

this_month = Time.zone.today.beginning_of_month

this_month.all_month.each do |date|
  ROUTES.each_key do |route_slug|
    DRIVER_EMAILS.each do |driver_email|
      driver = User.find_by!(email_address: driver_email)

      create_trip!(
        driver: driver,
        route_slug: route_slug,
        date: date,
        time: TIMES.sample
      )
    end
  end
end
