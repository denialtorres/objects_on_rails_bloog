class Exhibit < SimpleDelegator

  def self.exhibits
    [
     TextPostExhibit,
     PicturePostExhibit,
     LinkExhibit
    ]
  end

  def initialize(model, context)
    @context = context
    super(model)
  end

  def self.exhibit(object, context)
    exhibits.inject(object) do |object, exhibit|
      exhibit.exhibit_if_applicable(object, context)
    end
  end

  def self.exhibit_if_applicable(object, context)
    if applicable_to? object
      new(object, context)
    else
      object
    end
  end

  def self.applicable_to?(object)
    false
  end
end
