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

		if charge.paid
			Order.create(
				product: @product,
				user: @user,
				total: @product.price
			)
			redirect_to product_path(@product), notice: "Tu pago ha sido procesado con éxito. En breve recibirás un correo electrónico con todos los detalles. ¡Muchas gracias por tu compra!"
		end

		rescue Stripe::CardError => e
			# Card declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"

			logStripeError(e, err)
		rescue Stripe::RateLimitError => e
  		# Too many requests made to the API too quickly
  			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
			logStripeError(e, err)
		rescue Stripe::InvalidRequestError => e
  		# Invalid parameters were supplied to Stripe's API
  			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
			logStripeError(e, err)
		rescue Stripe::AuthenticationError => e
  		# Authentication with Stripe's API failed
  		# (maybe you changed API keys recently)
  			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
			logStripeError(e, err)
		rescue Stripe::APIConnectionError => e
  		# Network communication with Stripe failed
  			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
			logStripeError(e, err)
		rescue Stripe::StripeError => e
  		# Display a very generic error to the user, and maybe send
  		# yourself an email
  			body = e.json_body
			err = body[:error]
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
			logStripeError(e, err)
		rescue => e
  		# Something else happened, completely unrelated to Stripe
  			body = e.message
			flash[:error] = "Desafortunadamente, hubo un error al procesar tu pago: #{err[:message]}"
			puts body
		end	
	end

	def self.logStripeError(e, err)
		puts "Status is: #{e.http_status}"
  		puts "Type is: #{err[:type]}"
  		puts "Charge ID is: #{err[:charge]}"
		puts "Code is: #{err[:code]}" if err[:code]
  		puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
  		puts "Param is: #{err[:param]}" if err[:param]
  		puts "Message is: #{err[:message]}" if err[:message]
	end
end
