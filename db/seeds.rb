# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.find_or_create_by(email: 'sirbuland.temp@gmail.com')
user.password = "123456"
user.password_confirmation = "123456"
user.save

start_date = DateTime.parse("1/1/2022")
end_date = DateTime.parse("30/11/2022")

while start_date <= end_date do
  reading_time = start_date.beginning_of_day
  4.times do
    random_reading = rand(1...700)
    reading = user.patient.glucometer_readings.find_or_initialize_by(reading: random_reading, created_at: reading_time)
    reading.save(validate: false)
    reading_time += 5.hours
  end
  start_date += 1.day
end


