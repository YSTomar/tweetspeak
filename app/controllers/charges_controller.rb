class ChargesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :cancel]
  before_filter :only_inactive_customers, only: [:new, :create, :cancel]

	def new
	end

	def create

	  Stripe.api_key = ENV["STRIPE_API_KEY"]

		# Get the credit card details submitted by the form
		token = params[:stripeToken]

		if !current_user.customer_id?
			customer = Stripe::Customer.create(
  				:card => params[:stripeToken],
  				:description => current_user.email
  			)
		else
			customer = current_user.customer_id
		end

  		type = params[:membership]

  		if type = "monthly"
			customer.subscriptions.create(:plan => "ts_monthly")

  		elsif type = "yearly"
  			customer.subscriptions.create(:plan => "ts_monthly")

  		else
	  		Stripe::Charge.create(
			    :amount => 97*100, # incents 
			    :currency => "usd",
			    :customer => customer.id
			)	  
	  	end
	  
	  if !customer.default_card.nil?
		  flash[:notice] = "Charge went well"
		  current_user.active_subscription = true
		  current_user.update_attribute(:customer_id, customer.id)
		  current_user.save
		  redirect_to pages_dashboard_path
		end

	  rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to charges_path

	end

	def update
	end

	def cancel
		flash[:notice] = "Hate to see you go!"
		@customer = Stripe::Customer.retrieve(current_user.customer_id) 
		@customer.subscriptions.first.delete() 
		current_user.active_subscription = false
		current_user.save
		redirect_to root_path
	end

	def only_inactive_customers
		if current_user
			if current_user.active_subscription
				redirect_to pages_dashboard_path
			end
		end
		return true
	end
end
