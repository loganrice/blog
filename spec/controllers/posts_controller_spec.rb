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
    context "with admin user" do 
      let(:admin) { FactoryGirl.create(:user, admin: true) } 

      it "assigns a new instance of post" do
        sign_in :user, admin
        get :new
        expect(assigns(:post)).to be_a Post
      end
    end
    context "without an admin user" do
      let(:admin) { FactoryGirl.create(:user, admin: false) } 

      it "redirects to the root path" do 
        sign_in :user, admin
        get :new
        expect(response).to redirect_to root_path
      end

      it "sets a flash notice" do 
        sign_in :user, admin
        get :new
        expect(flash[:notice]).to  be_present
      end
    end
  end

  describe "Create" do
    context "with admin user" do 
      let(:admin) { FactoryGirl.create(:user, admin: true) } 

      it "creates a post" do
        sign_in :user, admin
        post :create, post: { title: "Awesome Blog", text: "Once upon a time..."}
        expect(Post.first.title).to eq("Awesome Blog")
      end
    end
  end

  describe "Edit" do
    context "with admin user" do 
      let(:admin) { FactoryGirl.create(:user, admin: true) } 

      it "assigns post" do
        sign_in :user, admin
        blog_post = FactoryGirl.create(:post)
        get :edit, id: blog_post
        expect(assigns(:post).id).to eq(blog_post.id)
      end
    end
  end

  describe "Update" do
    context "with admin user" do 
      let(:admin) { FactoryGirl.create(:user, admin: true) } 

      it "changes the title and text of a post" do
        blog_post = FactoryGirl.create(:post)
        sign_in :user, admin
        post :update, id: blog_post.slug, post: { title: 'First Post', text: 'Hello World' }
        expect(Post.first.title).to eq('First Post')
        expect(Post.first.text).to eq('Hello World')
      end

      it "redirects to the root path" do
        sign_in :user, admin
        blog_post = FactoryGirl.create(:post)
        blog_post = FactoryGirl.create(:post)
        post :update, id: blog_post.slug, post: { title: 'First Post', text: 'Hello World' }
        expect(response).to redirect_to root_path
      end
    end
  end
end

