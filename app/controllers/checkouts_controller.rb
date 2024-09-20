class CheckoutsController < ApplicationController
  def new 
  end

  def create
    Stripe.api_key =
      'sk_test_51Q0JRkSJa7berXzqg3qRVGb6eHLYRBSaordod08CJZpMT5s3q7s3Q1LwzN3wAungu08faNfanCvh4fETdhFNzN3300R6mrCbpW'
    @num_of_tickets = params[:num_of_tickets].to_i
    @price = params[:price].to_i
   
    @show = Show.find(params[:show_id])
    seat_ids = params[:booking][:seat_ids]

    @sessions =
      Stripe::Checkout::Session.create(
        {
          payment_method_types: ['card'],
          line_items: [
            {
              price_data: {
                currency: 'usd',
                product_data: {
                  name: 'Booking',
                },
                unit_amount: @price,
              },
              quantity: @num_of_tickets,
            },
          ],
          mode: 'payment',
          success_url:
          bookings_url(
            
              controller: 'bookings',
              action: 'create',
              show_id: @show.id,
              num_of_tickets: @num_of_tickets,
              user_id: current_user.id,
              price: @price,
              seat:  seat_ids,
              only_path: false,
            ),
          cancel_url: admin_movies_url(only_path: false),
        },
      )
      redirect_to @sessions.url, allow_other_host: true
    end
end
