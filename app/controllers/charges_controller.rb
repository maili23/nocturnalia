class ChargesController < ApplicationController

	def new
	end

	def create
		token = params[:stripeToken]
		@product = Product.find(params[:product_id])
		@user = current_user

		begin
		charge = Stripe::Charge.create(
			amount: (@product.price*100).round,
			source: token,
			description: params[:stripeEmail],
			currency: 'mxn'
		)

		rescue Stripe::CardError => e
			# Card declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"

			puts "Status is: #{e.http_status}"
  			puts "Type is: #{err[:type]}"
  			puts "Charge ID is: #{err[:charge]}"
			puts "Code is: #{err[:code]}" if err[:code]
  			puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
  			puts "Param is: #{err[:param]}" if err[:param]
  			puts "Message is: #{err[:message]}" if err[:message]
		rescue Stripe::RateLimitError => e
  		# Too many requests made to the API too quickly
  			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
		rescue Stripe::InvalidRequestError => e
  		# Invalid parameters were supplied to Stripe's API
  		body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
		rescue Stripe::AuthenticationError => e
  		# Authentication with Stripe's API failed
  		# (maybe you changed API keys recently)
  		body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
		rescue Stripe::APIConnectionError => e
  		# Network communication with Stripe failed
  		body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
		rescue Stripe::StripeError => e
  		# Display a very generic error to the user, and maybe send
  		# yourself an email
  		body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
		rescue => e
  		# Something else happened, completely unrelated to Stripe
  		body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
  		redirect_to product_path(@product)
		end

		redirect_to product_path(@product)
		flash[:notice] = "Tu pago ha sido procesado con éxito. En breve recibirás un correo electrónico con todos los detalles. ¡Muchas gracias por tu compra!"
	end
end
