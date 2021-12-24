class ApplicationController < ActionController::Base
  before_action :init_blog

  helper :exhibits

  private

  def init_blog
    @blog = THE_BLOG
  end
end
