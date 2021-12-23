require 'rails_helper'
require 'minitest/autorun'
require 'rr'

RSpec.describe Post do
  let(:post) { Post.new(title: 'title') }

  it 'is not valid with a blank title' do
    [nil, "", " "].each do |bad_title|
      post.title = bad_title
      expect(post.valid?).not_to be_truthy
    end
  end

  it "is valid with a non-blank title" do
    post.title = "title"
    expect(post.valid?).to be_truthy
  end

  it 'starts with blank attributes' do
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

    describe "given an invalid post" do
      it 'wont add the post to the blog' do
        blog = Blog.new

        post.title = nil

        blog.add_entry(post)

        expect(post.publish).to be_falsey
      end
    end
  end

  describe '#pubdate' do
    describe 'before publishing' do
      it 'is blank' do
        expect(post.pubdate).to be_nil
      end
    end

    describe 'after publishing' do
      before do
        # mock the blog
        clock = double('clock')
        @now = DateTime.parse("2011-09-11T02:56")

        allow(clock).to receive(:now){ @now }

        blog = double('blog')
        allow(blog).to receive(:add_entry){ post }

        post.blog = blog
        post.publish(clock)
      end


      it 'is a datetime' do
        expect(post.pubdate.class).to eq(DateTime)
      end

      it 'is the corrurent time' do
        expect(post.pubdate).to eq(@now)
      end
    end
  end
end
