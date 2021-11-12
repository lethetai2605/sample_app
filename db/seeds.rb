# Create a main sample user.
User.create!(name: "Example User",
    email: "admin@admin.com",
    password: "123",
    password_confirmation: "123",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

    # Generate a bunch of additional users.
    20.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
    end
    
    users = User.order(:created_at).take(6)
    50.times do
        content = Faker::Lorem.sentence(word_count: 5)
        users.each { |user| user.microposts.create!(content: content) }
    end 

    # Create following relationships.
    users = User.all
    user = users.first
    following = users[2..50]
    followers = users[3..40]
    following.each { |followed| user.follow(followed) }
    followers.each { |follower| follower.follow(user) }