require 'rails_helper'

describe PicturePostExhibit do
  before do
    @post = OpenStruct.new(
      title: "TITLE",
      body: "Body",
      pubdate: "PUBDATE"
    )
    @context = double()
    @it = PicturePostExhibit.new(@post, @context)
  end

  it "delegates method calls to the post" do
    expect(@it.title).to eq("TITLE")
    expect(@it.body).to eq("Body")
    expect(@it.pubdate).to eq("PUBDATE")
  end
end
