class PicturePostExhibit < Exhibit
  def self.applicable_to?(object)
    object.picture?
  end

  def render_body
    @context.render(partial: "/posts/picture_body", locals: { post: self })
  end
end
