FactoryGirl.define do
  factory :post do
    title "Post title"
    body "Post bodies must be pretty long."

    after(:build) do |post|
      post.class.skip_callback(:create, :after, :create_vote)
    end
  end
end