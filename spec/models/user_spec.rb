require 'rails_helper'

describe User do

  include TestFactories

  describe "#favorited(post)" do
    
    before do
      @user = authenticated_user
      @post = @user.posts.create(title: 'Post', body: 'Post bodies must be pretty long.')
    end

    it "returns nil if the user has not favorited the post" do 
      expect(@user.favorited(@post)).to eq(nil)     
    end

    it "returns the appropriate favorite if it exists" do
      faved_post = Favorite.create(user_id: @user.id, post_id: @post.id)
      
      expect(@user.favorited(@post)).to eq(faved_post)
    end
  end  
end
