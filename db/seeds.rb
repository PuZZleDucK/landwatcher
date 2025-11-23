Watch.destroy_all
Property.destroy_all
User.destroy_all

10.times do
    name = Faker::Ancient.unique.hero
    email_slug = name.downcase.gsub(' ', '_')
    User.create!(
        name: name,
        email: "#{email_slug}@example.com",
        password: 'password',
        password_confirmation: 'password',
        devise_jwt_secret_key: SecureRandom.hex(10)
    )
end

1000.times do
    type_index = Faker::Number.between(from: 0, to: 4)
    property_type = Property.property_types.key(type_index)
    Property.create!(
        title: "#{property_type} - #{Faker::Company.name}",
        description: Faker::Company.catch_phrase,
        price: Faker::Number.number(digits: 5),
        bedrooms: Faker::Number.between(from: 1, to: 5),
        property_type: property_type
    )
end

50.times do
    user = User.order('RANDOM()').first
    property = Property.order('RANDOM()').first
    Watch.create!(user_id: user.id, property_id: property.id)
end

puts "Seeded #{User.count} users"
puts "Seeded #{Property.count} properties"
puts "Seeded #{Watch.count} watches"
