# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "posts", type: :graphql do
  context "query with no post" do
    it "should return nil" do
      result = RainyDaysSchema.execute(query)
      expect(result.dig("data")).not_to be_nil
      expect(result.dig("data", "posts")).to be_empty
    end
  end

  context "query with multiple posts" do
    before do
      user_with_posts
      user_with_posts(posts_count: 3)
    end

    it "should return 5 post list" do
      result = RainyDaysSchema.execute(query)
      expect(result.dig("data", "posts").length).to eq(5)
    end
  end

  context "query with a post and multiple comments on it" do
    before do
      post_with_comments
      post_with_comments(comments_count: 3)
    end

    it "should return comment count of 2 and 3" do
      result = RainyDaysSchema.execute(query)
      expect(result.dig("data", "posts").length).to eq(2)
      expect(result.dig("data", "posts").map {|e| e["commentCount"]}).to match_array([2, 3])
    end
  end

  def user_with_posts(posts_count: 2)
    FactoryBot.create(:user) do |user|
      FactoryBot.create_list(:post, posts_count, user: user)
    end
  end

  def post_with_comments(comments_count: 2)
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, user: user) do |post|
      FactoryBot.create_list(:comment, comments_count, user: user, post: post)
    end
  end

  def query
    <<-gql
    query {
      posts {
        id
        title
        excerpt
        commentCount
        email
        username
        updatedAt
      }
    }
    gql
  end
end
