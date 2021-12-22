require 'rails_helper'

RSpec.describe Blog do
  before do
    @it = Blog.new
  end

  it 'has no entries' do
    expect(@it.entries).to be_empty
  end
end
