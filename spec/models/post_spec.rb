require 'rails_helper'

describe Post do
  describe "#generate_slug" do
    it "removes white space" do
      post = FactoryGirl.create(:post, title: "a great article")
      expect(post.slug).to eq("a-great-article")
    end

    it "removes special characters" do 
      post = FactoryGirl.create(:post, title: "a!@great#article")
      expect(post.slug).to eq("a-great-article")
    end

    it "downcases string" do
      post = FactoryGirl.create(:post, title: "A Great Article")
      expect(post.slug).to eq("a-great-article")
    end

    it "adds a suffix if there are more than one with the same title" do
      post1 = FactoryGirl.create(:post, title: "A Great Article")
      post2 = FactoryGirl.create(:post, title: "A Great Article")
      expect(post2.slug).to eq("a-great-article-2")
    end
  end
end
