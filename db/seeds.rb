class_list = [
  ["First Class", 1.1],
  ["Business Class", 1.06],
  ["Economy", 1.03]
]

country_list = [
  ["Nigeria", "NGN", "+234", "Naira", 315],
  ["Kenya", "KES", "+254", "Shillings", 101],
  ["United States", "USD", "+1", "Dollars", 1]
]

state_list = [
  ["Abuja", 1],
  ["Lagos", 1],
  ["Rivers", 1],
  ["Enugu", 1],
  ["Kano", 1],
  ["Cross River", 1],
  ["Plateau", 1],
  ["Kaduna", 1],
  ["Imo", 1],
  ["Delta", 1],
  ["Oyo", 1],
  ["Sokoto", 1],
  ["Borno", 1],
  ["Ondo", 1],
  ["Kwara", 1],
  ["Niger", 1],
  ["Adamawa", 1],
  ["Kajiado", 2],
  ["Mombasa ", 2],
  ["Uasin Gishu", 2],
  ["Turkana", 2],
  ["Garissa", 2],
  ["Tana River", 2],
  ["Kakamega", 2],
  ["Kericho", 2],
  ["Taita-Taveta", 2],
  ["Elgeyo-Marakwet", 2],
  ["Kisumu", 2],
  ["Trans-Nzoia", 2],
  ["Lamu", 2],
  ["Marsabit", 2],
  ["Kilifi", 2],
  ["Mandera", 2],
  ["Narok", 2],
  ["Nairobi", 2],
  ["Nakuru", 2],
  ["Laikipia", 2],
  ["Nyeri", 2],
  ["Samburu", 2],
  ["Wajir", 2]
]

airport_list = [
  ["Eldoret International Airport", "Eldoret", "EDL", 20],
  ["Moi International Airport", "Mombasa", "MBA", 19],
  ["Jomo Kenyatta International Airport", "Nairobi", "NBO", 35],
  ["Nnamdi Azikiwe International Airport", "Abuja", "ABV", 1],
  ["Murtala Muhammed International Airport", "Lagos", "LOS", 2],
  ["Port Harcourt International Airport", "Port Harcourt", "PHC", 3],
  ["Akanu Ibiam International Airport", "Enugu", "ENU", 4],
  ["Mallam Aminu Kano International Airport", "Kano", "KAN", 5],
  ["Margaret Ekpo International Airport", "Calabar", "CBQ", 6],
  ["Sadiq Abubakar III International Airport", "Sokoto", "SKO", 12],
  ["Maiduguri International Airport", "Maiduguri", "MIU", 13],
  ["Asaba International Airport", "Asaba", "ABB", 10],
  ["Yakubu Gowon Airport", "Jos", "JOS", 7],
  ["Kaduna Airport", "Kaduna", "KAD", 8],
  ["Warri Airport", "Warri", "QRW", 10],
  ["Zaria Airport", "Zaria", "ZAR", 8],
  ["Sam Mbakwe Airport", "Owerri", "QOW", 9],
  ["Ibadan Airport", "Ibadan", "IBA", 11],
  ["Akure Airport", "Akure", "AKR", 14],
  ["Ilorin Airport", "Ilorin", "ILR", 15],
  ["Minna Airport", "Minna", "MXJ", 16],
  ["Yola Airport", "Yola", "YOL", 17],
  ["Amboseli Airport", "Amboseli", "ASV", 18],
  ["Bamburi Airport", "Bamburi", "BMQ", 19],
  ["Eliye Springs Airport", "Eliye Springs", "EYS", 21],
  ["Garissa Airport", "Garissa", "GAS", 22],
  ["Hola Airport", "Hola", "HOA", 23],
  ["Kakamega Airport", "Kakamega", "GGM", 24],
  ["Kalokol Airport", "Kalokol", "KLK", 21],
  ["Kericho Airport", "Kericho", "KEY", 25],
  ["Kilaguni Airport", "Kilaguni", "ILU", 26],
  ["Kimwarer Airport", "Kimwarer", "KRV", 27],
  ["Kisumu Airport", "Kisumu", "KIS", 28],
  ["Kitale Airport", "Kitale", "KTL", 29],
  ["Kiwayu Airport", "Kiwayu", "KWY", 30],
  ["Manda Airport", "Lamu", "LAU", 30],
  ["Lodwar Airport", "Lodwar", "LOK", 21],
  ["Loiyangalani Airport", "Loiyangalani", "LOY", 31],
  ["Malindi Airport", "Malindi", "MYD", 32],
  ["Mandera Airport", "Mandera", "NDE", 33],
  ["Marsabit Airport", "Marsabit", "RBT", 31],
  ["Keekorok Airport", "Masai Mara", "MRE", 34],
  ["Wilson Airport", "Nairobi", "WIL", 35],
  ["Nakuru Airport", "Nakuru", "NUU", 36],
  ["Nanyuki Airport", "Nanyuki", "NYK", 37],
  ["Nyeri Airport", "Nyeri", "NYE", 38],
  ["Samburu Airport", "Samburu", "UAS", 39],
  ["Wajir Airport", "Wajir", "WJR", 40]
]

user_data = {
  first_name: "Chineze",
  last_name: "Nwosu",
  email: 'afridiva@yahoo.com',
  password: "password",
  password_confirmation: "password"
}
User.create(user_data)

class_list.each do |name, tax_percent|
  TravelClass.create(name: name, tax_percent: tax_percent)
end

country_list.each do |name, iso, code, currency, exchange_rate|
  Country.create(name: name,
                 country_code: code,
                 currency: currency,
                 iso_currency: iso,
                 exchange_rate: exchange_rate)
end

state_list.each do |name, country_id|
  State.create(name: name, country: Country.find(country_id))
end

airport_list.each do |name, city, iata, state_id|
  Airport.create(name: name, 
                 city: city,
                 iata_code: iata,
                 state: State.find(state_id))
end

def iata(number)
  Airport.find(number).iata_code
end

(1..3).each do |number|
  (1..9).each do |kenya_number|
    Route.create(name: "#{iata(number)}-#{iata(kenya_number + 3)}",
                 departure_airport: Airport.find(number),
                 arrival_airport: Airport.find(kenya_number + 3))
    Route.create(name: "#{iata(kenya_number + 3)}-#{iata(number)}",
                 departure_airport: Airport.find(kenya_number + 3),
                 arrival_airport: Airport.find(number))
  end
end

(1..47).each do |number|
  Route.create(name: "#{iata(number)}-#{iata(number + 1)}",
               departure_airport: Airport.find(number),
               arrival_airport: Airport.find(number + 1))
  Route.create(name: "#{iata(number + 1)}-#{iata(number)}",
               departure_airport: Airport.find(number + 1),
               arrival_airport: Airport.find(number))
end

(1..50).each do
  Aircraft.create(tail_number: "5N-#{Faker::Internet.password(4, 4).upcase}",
                  economy_capacity: Faker::Number.between(100, 250),
                  business_capacity: Faker::Number.between(0, 15),
                  first_capacity: Faker::Number.between(5, 10))
end

(1..50).each do
  Aircraft.create(tail_number: "5Y-#{Faker::Internet.password(4, 4).upcase}",
                  economy_capacity: Faker::Number.between(100, 300),
                  business_capacity: Faker::Number.between(0, 20),
                  first_capacity: Faker::Number.between(6, 15))
end

(1..54).each do |number|
  Airfare.create(service_charge_in_dollar: Faker::Number.between(700, 1200),
                 route: Route.find(number),
                 travel_class: TravelClass.find(1))
  Airfare.create(service_charge_in_dollar: Faker::Number.between(520, 690),
                 route: Route.find(number),
                 travel_class: TravelClass.find(2))
  Airfare.create(service_charge_in_dollar: Faker::Number.between(300, 500),
                 route: Route.find(number),
                 travel_class: TravelClass.find(3))
end

(1..94).each do |number|
  Airfare.create(service_charge_in_dollar: Faker::Number.between(117, 200),
                 route: Route.find(number + 54),
                 travel_class: TravelClass.find(1))
  Airfare.create(service_charge_in_dollar: Faker::Number.between(93, 113),
                 route: Route.find(number + 54),
                 travel_class: TravelClass.find(2))
  Airfare.create(service_charge_in_dollar: Faker::Number.between(60, 90),
                 route: Route.find(number + 54),
                 travel_class: TravelClass.find(3))
end

def seed_flight(min, max, min_time, max_time)
  (1..100).each do |number|
    fdate = Faker::Time.between(Date.today, 40.days.from_now, :all)
    farrival = Faker::Time.between(fdate + min_time, (fdate + max_time), :all)
    Flight.create(departure_date: fdate,
                  arrival_date: farrival,
                  aircraft: Aircraft.find(Faker::Number.between(1, 100)),
                  route: Route.find(Faker::Number.between(min, max)))
  end
end

seed_flight(1, 54, 3.hour, 6.hours)
seed_flight(55, 148, 1.hour, 2.hours)