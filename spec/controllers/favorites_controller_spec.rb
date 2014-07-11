require 'rails_helper'

describe FavoritesController do

  include TestFactories
  include Devise::TestHelpers

  before do 
    @topic = Topic.create
    @post = associated_post
    @user = authenticated_user
    sign_in @user
  end

  describe '#create' do
    it "creates a favorite for the current user and specified post" do
      expect( @user.favorites.find_by(post_id: @post.id) ).to be_nil

      post :create, { post_id: @post.id }

      expect( @user.favorites.find_by(post_id: @post.id) ).not_to be_nil
    end
  end

  describe '#destroy' do
    it "destroys the favorite for the current user and post" do
      favorite = @user.favorites.where(post: @post).create
      expect( @user.favorites.find_by(post_id: @post.id) ).not_to be_nil

      delete :destroy, { post_id: @post.id, id: favorite.id }

      expect( @user.favorites.find_by(post_id: @post.id) ).to be_nil
    end
  end
end