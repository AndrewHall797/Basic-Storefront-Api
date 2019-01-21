class CartsController < ApplicationController
  
  # Used to create a new cart with its own name
  def create
    cart = Cart.new(params.require(:cart).permit(:name))
    
    if cart.save
      render json: "Success, a cart was created!"    
    else
      render json: "Failure, a cart was not created"
    end
    
  end

  # sends back a list of all carts
  def index
    render json: {carts: Cart.all}
  end

  #used to destroy a cart
  def destroy
      if  (cart = Cart.find_by(name: params[:name])) != nil
          cart.delete
          render json: "Success, the cart was deleted"
      else
          render json "Failure, a cart was not deleted"
      end
  end

  # retuns a list of all the products in a cart
  def show
    render json: {cart: Cart.find_by(name: params[:name]).products}
  end 
  
  # used to add a product to the desired cart which is selected by entering the products name and carts name
  def add_product
    
    product = Product.find_by(name: params[:name_product])
    cart = Cart.find_by(name: params[:name_cart])
    
    if product.inventory_count <= 0
      rener json: "Sorry there is not inventory left in this product"
    end
    
    customer = Customer.new(:product => product , :cart => cart)
    if customer.save
      product.inventory_count = product.inventory_count - 1
      render json: "A product was added to your cart"
    else
      render json: "A product was not added to your cart"
    end
  end
  
  # used to checkout a cart which sends back the total price of all the contents and deletes the cart
  def checkout
    cart_total = Cart.find_by(name: params[:name]).products.sum { |p| p.price }
    
    Cart.find_by(name: params[:name]).delete
    
    render json: {sum: cart_total}
  end
  
end
