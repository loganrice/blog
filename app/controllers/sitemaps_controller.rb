class SitemapsController < ApplicationController
  layout :false

  def index
    
    headers['Content-Type'] = 'application/xml'
    last_post = Post.last
    if stale?(last_post)
      @posts = Post.all 
    end
  end
end
