require 'rails_helper'

describe User do
  
  include TestFactories

  describe "#favorited(post)" do

    before do 
      @user = authenticated_user
      @post = associated_post
    end

    it "returns `nil` if the user has not favorited the post" do
      expect( @user.favorited(@post) ).to eq(nil)
    end

    it "returns the appropriate favorite if it exists" do
      favorite = @user.favorites.where(post: @post).create
      expect( @user.favorited(@post) ).to eq(favorite)
    end
  end
end