class Blog
  attr_writer :post_source, :entries

  def initialize
    @entries = []
  end

  def title
    "Watching Paint Dry"
  end

  def subtitle
    "The trusted source for drying paint & opinion"
  end

  def new_post(*args)
    post_source.call(*args).tap do |p|
      p.blog = self
    end
  end

  def entries
    @entries.sort_by{|e| e.pubdate}.reverse.take(10)
  end

  def add_entry(entry)
    @entries << entry
  end

  private

  def post_source
    # public_method inistatiates a callable Method object
    # When the objects #call method is invoked it will be
    # as if we called the named method on the original object
    # public_method respects public/private boundaries and will
    # generate a Method object for a private method
    @post_source ||= Post.public_method(:new)
  end
end
