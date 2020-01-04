class CartsController < ApplicationController
  def add
    # 搬出購物車
    current_cart.add_item(params[:id])
    session["cart9527"] = current_cart.serialize

    redirect_to root_path, notice: '已加入購物車'
  end
end

