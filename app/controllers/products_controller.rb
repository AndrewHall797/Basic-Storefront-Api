class ProductsController < ApplicationController
  
  def create
      product = Product.new(params.require(:product).permit(:name , :price , :inventory_count))
      if product.save
          render json: "Success, a new product was added to the list"
      else
          render json: "Failure , a new product was not added to the list"
      end
  end

  def destroy
      if  (product = Product.find_by(name: params[:name])) != nil
          product.delete
          render json: "Success, the product was deleted"
      else
          render json "Failure, a product was not deleted"
      end
  end

  def index
      render json: {products: Product.all}
  end
  
  def index_avalible
      avalible = Array.new
      
      for product in Product.all
        if product.inventory_count != 0
            avalible.push(product)
        end
      end
      
      render json: {products: avalible}
  end

  def show
    render json: {product: Product.find_by(name: params[:name])}
  end
  
  def update
      Product.update(Product.find_by(name: params[:name]).id , "inventory_count" => params[:count])
      render json: "Success, the object was updated"
  end
  
  def purchase
      product = Product.find_by(name: params[:name])
      puts product.inventory_count

      if (product.inventory_count > 0 && product != nil)
        Product.update(product.id , "inventory_count" => (product.inventory_count - 1))
        render json: "Success, the current inventory_count of the object is " + product.inventory_count.to_s
      else
        render json: "You could not purchase a product as there is no invetory"
      end
      
  end
  
end
