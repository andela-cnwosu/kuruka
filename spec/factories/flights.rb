FactoryGirl.define do
  factory :flight do
    departure_date Time.zone.now + 86_400
    arrival_date Time.zone.now + 86_400 * 7
    aircraft
    route

    factory :departed do
      departure_date Time.zone.now - 86_400
    end
  end
end

