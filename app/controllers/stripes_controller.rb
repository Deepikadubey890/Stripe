class StripesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create_user 
		@user = User.new(name: params[:name], email: params[:email])
		if @user.save 
			render json: @user  
		else
			render json: {"message": "Not created"}
		end
	end

	def create_stripe_user 
		@user = User.find_by(id: params[:id])
		@customer = Stripe::Customer.create({
			name: @user.name,
			email: @user.email
		})
		
		@user.update(stripe_id: @customer.id)
		render json: @customer
	end

	def create_product
		@product = Product.new(title: params[:title], price: params[:price])
		if @product.save 
			render json: @product
		else
			render json: {"message": "Not created"}
		end
	end

	def checkout 
		@product = Product.find_by(id: params[:id])
		session = Stripe::Checkout::Session.create({
	    line_items: [{
	      price_data: {
	        currency: 'usd',
	        product_data: {
	          name: @product.title,
	        },
	        unit_amount: @product.price,
	      },
	      quantity: 1,
	    }],
	    mode: 'payment',
	    success_url: 'https://example.com/success',
	    cancel_url: 'https://example.com/cancel',

  })
		 render json: session

	end
end
