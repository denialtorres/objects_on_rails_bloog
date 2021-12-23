require 'rails_helper'

RSpec.describe Blog do
  before do
    @it = Blog.new
  end

  it 'has no entries' do
    expect(@it.entries).to be_empty
  end

  describe "#new_post" do
    before do
      @new_post = OpenStruct.new
      @it.post_source = -> { @new_post }
    end

    it 'returns a new post' do
      expect(@it.new_post).to eq(@new_post)
    end

    it "sets the post's blog reference to itself" do
      expect(@it.new_post.blog).to eq(@it)
    end

    it "Accepts an attribute hash on behalf of the post maker" do
      post_source = spy "post_source"
      @it.post_source  = post_source
      @it.new_post(x: 42, y: 'z')

      expect(post_source).to have_received(:call).with({x: 42, y: 'z'})
    end
  end

  describe "#entries" do
    def stub_entry_with_date(date)
      OpenStruct.new(pubdate: DateTime.parse(date))
    end

    it 'is sorted in reverse-cronological order' do
      oldest = stub_entry_with_date("2011-09-09")
      newest = stub_entry_with_date("2011-09-11")
      middle = stub_entry_with_date("2011-09-10")

      @it.add_entry(oldest)
      @it.add_entry(newest)
      @it.add_entry(middle)

      expect(@it.entries).to eq([newest, middle, oldest])
    end

    it 'is limited to 10 items' do
      10.times do |i|
        @it.add_entry(stub_entry_with_date("2011-09-#{i + 1}"))
      end

      oldest = stub_entry_with_date("2011-08-30")

      @it.add_entry(oldest)

      expect(@it.entries.size).to eq(10)
      expect(@it.entries).not_to include(oldest)
    end
  end

  describe "#add_entry" do
    it "adds the entry to the blog" do
      entry = OpenStruct.new(pubdate: DateTime.now)
      @it.add_entry(entry)
      expect(@it.entries).to include(entry)
    end
  end
end
