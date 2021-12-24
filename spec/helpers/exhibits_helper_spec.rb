require 'rails_helper'

RSpec.describe ExhibitsHelper do
  before do
    @it = Object.new
    @it.extend ExhibitsHelper
    @context = double()
  end

  it "decorates picture posts with a PicturePostExhibit" do
    post = Post.new

    allow(post).to receive(:picture?).and_return(true)
    expect(@it.exhibit(post, @context).class).to eq(PicturePostExhibit)
  end

  it "decorates text post with a TextPostExhibit" do
    post = Post.new
    allow(post).to receive(:picture?).and_return(false)
    expect(@it.exhibit(post, @context).class).to eq(TextPostExhibit)
  end

  it 'leaves objects it doesnt know about alone' do
    model = Object.new
    expect(@it.exhibit(model, @context)).to eq(model)
  end
end
