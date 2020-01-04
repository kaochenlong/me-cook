class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :current_cart

  private
  def not_found
    render file: 'public/404.html', 
           status: 404, 
           layout: false
  end

  def current_cart
    @cart ||= Cart.from_hash(session["cart9527"])
  end
end

