class CheckoutCreator
    attr_reader :current_user, :course, :checkout_success_url, :checkout_cancel_url, :payment, :session_id, :expand
    def call
        create_checkout
    end

    # def call_retrieve
    #     retrieve_checkout
    # end
    def initialize(current_user, course, checkout_success_url, checkout_cancel_url, payment)
        @current_user = current_user
        @course = course
        @checkout_success_url = checkout_success_url
        @checkout_cancel_url = checkout_cancel_url
        @payment = payment
        # @session_id = session_id
        # @expand = expand
    end
    
    # private



    def create_checkout
        return (Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
                price_data: {currency: 'inr', product_data: {name: course.course_name}, unit_amount: course.course_price * 100},
                quantity: 1,
            } ],
            mode: 'payment',
            success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}" + "&payment_id=" + payment.id.to_s,
            cancel_url: checkout_cancel_url + "?session_id={CHECKOUT_SESSION_ID}" + "&payment_id=" + payment.id.to_s
        }))
    end

    # def retrieve_checkout
    #     return (Stripe::Checkout::Session.retrieve({ id: session_id, expand: expand}))
    #     return (Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]}))
    # end
end