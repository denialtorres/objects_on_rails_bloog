require 'rails_helper'
require 'minitest/autorun'

RSpec.describe Post do
  let(:post) { Post.new }

  it 'starts with blank attributes' do
    expect(post.title).to be_nil
    expect(post.body).to be_nil
  end

  it "supports reading and writing a title" do
    post.title = "foo"
    expect(post.title).to eq "foo"
  end

  it "supports reading and writing a post body" do
    post.body = "foo"
    expect(post.body).to eq("foo")
  end

  it "supporst reading and writing a blog reference" do
    blog = Object.new
    post.blog = blog
    expect(post.blog). to eq(blog)
  end

  it 'supports setting attributes in the initializer' do
    it = Post.new(title: "mytitle", body: "mybody")
    expect(it.title).to eq("mytitle")
    expect(it.body).to eq("mybody")
  end

  describe "#publish" do
    it "add the post to the blog" do
      blog = spy("blog")
      post.blog = blog
      post.publish
      expect(blog).to have_received(:add_entry).with(post)
    end
  end
end
