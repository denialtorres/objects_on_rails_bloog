class Post
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming


  attr_accessor :blog, :title, :body, :pubdate, :image_url

  validates :title, presence: true

  def initialize(attrs={})
    attrs.each do |k, v| send("#{k}=", v) end
  end

  def publish(clock=DateTime)
    return false unless valid?

    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def persisted?
    false
  end
end
