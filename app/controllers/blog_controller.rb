class BlogController < ApplicationController
  def index
    post1 = @blog.new_post
    post1.title = "Paint just applied"
    post1.body = "Paint just applied. It's a lovely orangey-purple"
    post1.publish

    post2 = @blog.new_post(title: 'Still Wet')
    post2.body = "Paint is still quite wet, not bubbling yet!"
    post2.publish
  end
end
