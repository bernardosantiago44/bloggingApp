class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :home ]

  def home
    @blogs = Blog.all
  end
end
