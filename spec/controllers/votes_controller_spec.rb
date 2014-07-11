require 'rails_helper'

describe VotesController do 

  include TestFactories
  include Devise::TestHelpers

  before do 
    request.env["HTTP_REFERER"] = '/'
    @user = authenticated_user
    @post = associated_post
    sign_in @user
  end

  describe '#up_vote' do
    it "adds an up-vote to the post" do
      expect {
        post( :up_vote, post_id: @post.id )
      }.to change{ @post.up_votes }.by 1
    end
  end

  describe '#down_vote' do
    it "adds a down-vote to the post" do
      expect {
        post( :down_vote, post_id: @post.id )
      }.to change{ @post.down_votes }.by 1
    end
  end
end