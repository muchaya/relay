class StaticController < ApplicationController
  allow_unauthenticated_access

  def demo; end
end
