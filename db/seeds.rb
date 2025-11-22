Watch.destroy_all
Property.destroy_all
User.destroy_all

user = User.create!(name: 'REX', email: 'rex@example.com', password: 'password', password_confirmation: 'password')
property = Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
Property.create!(title: 'Bulwarks Ambry', description: 'Compact and quaint.', price: 55, bedrooms: 1, property_type: 1)
Property.create!(title: 'Sky Meadow', description: 'Lovely open space with a short hop to the moon.', price: 555555, bedrooms: 6, property_type: 2)
Watch.create!(user_id: user.id, property_id: property.id)
