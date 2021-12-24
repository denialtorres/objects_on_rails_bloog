require 'spec_helper'

describe 'posts/_picture_body.html.erb' do
  before do
    @post = OpenStruct.new(
      title: "TITLE",
      body: "Boby",
      pubdate: "PUBDATE",
      image_url: "IMAGE_URL"
    )
    @context = double()

    @it = PicturePostExhibit.new(@post, @context)
  end

  it "Renders itself with the appropiate partial" do
    @context.should_receive(:render).and_return("<figure>\n  <img src=\"IMAGE_URL\" />\n  <figcaption>\n    Boby\n  </figcaption>\n</figure>\n")

    render partial: "/posts/picture_body", locals: { post: @it}

    expect(@it.render_body).to eq(rendered)
  end
end
