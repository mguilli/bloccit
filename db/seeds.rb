require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

# Create topics
15.times do 
  Topic.create(
    name:         Faker::Lorem.sentence,
    description:  Faker::Lorem.paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do 
  post = Post.create(
    user:   users.sample,
    topic:  topics.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )  

  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  post.update_rank

end
posts = Post.all

# Create Comments
100.times do 
  Comment.create(
    user: users.sample,
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

# Create admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'password',
  role:     'admin'
)
admin.skip_confirmation!
admin.save

# Create moderator
moderator = User.new(
  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'password',
  role:     'moderator'     
)
moderator.skip_confirmation!
moderator.save

# Create member
member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'password'
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} user created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
