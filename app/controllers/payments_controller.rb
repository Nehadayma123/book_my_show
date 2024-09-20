class PaymentsController < ApplicationController
  def new; end

  def create
    customer =
      Stripe::Customer.create(
        { email: params[:stripeEmail], source: params[:stripeToken] },
      )

    charge =
      Stripe::Charge.create(
        {
          customer: current_user.id,
          amount: 500,
          description: 'Book my show',
          currency: 'usd',
        },
      )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
