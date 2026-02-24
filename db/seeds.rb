def seed(file)
  load Rails.root.join("db", "seeds", "#{file}.rb")
  puts "Seeded #{file}"
end

puts "Seeding #{Rails.env} database..."
seed "places"
seed "routes"