require 'rails_helper'

describe PostsController do
  describe "Index" do
    it "assigns posts" do
      blog_post = FactoryGirl.create(:post)
      get :index
      expect(assigns(:posts)).to eq([blog_post])
    end
  end

  describe "New" do
    it "assigns a new instance of post" do
      get :new
      expect(assigns(:post)).to be_a Post
    end
  end

  describe "Create" do
    it "creates a post" do
      post :create, post: { title: "Awesome Blog", text: "Once upon a time..."}
      expect(Post.first.title).to eq("Awesome Blog")
    end
  end

  describe "Edit" do
    it "assigns post" do
      blog_post = FactoryGirl.create(:post)
      get :edit, id: blog_post
      expect(assigns(:post).id).to eq(blog_post.id)
    end
  end

  describe "Update" do
    it "changes the title and text of a post" do
      blog_post = FactoryGirl.create(:post)
      post :update, id: blog_post.id, post: { title: 'First Post', text: 'Hello World' }
      expect(Post.first.title).to eq('First Post')
      expect(Post.first.text).to eq('Hello World')
    end

    it "redirects to the root path" do
      blog_post = FactoryGirl.create(:post)
      post :update, id: blog_post.id, post: { title: 'First Post', text: 'Hello World' }
      expect(response).to redirect_to root_path
    end
     
  end
end

