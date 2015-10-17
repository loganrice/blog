class Post < ActiveRecord::Base
  validates_presence_of :title
  after_validation :generate_slug

  def to_param
    self.slug
  end

  private

  def generate_slug
    begin
      title = remove_whitespace_and_special_characters(self.title.dup)
      posts = Post.where(slug: title)
      if posts.count >= 1
        self.slug = "#{title}-#{posts.count + 1}"
      else
        self.slug = title
      end
    rescue
      raise 'An error has occured while generating a slug. Ensure the Post title is not blank'
    end
  end

  def remove_whitespace_and_special_characters(title)
    title.gsub!(' ', '-')
    title.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    title.gsub!(/-+/, "-")
    title.downcase!
    return title
  end
end
