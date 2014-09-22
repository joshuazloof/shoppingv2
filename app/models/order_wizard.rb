class OrderWizard
  attr_reader :session, :params

  def initialize(session, params)
    @session = session
    @params = params
  end

  def new
    reset_session_order!     # Delete if you want to be able to "save" your place in the wizard
    order = Order.new(session_order_params)
    build_new_order_items_for order
    order.current_step = session[:order_step]
    order
  end

  def create
    order = Order.new session_order_params

    order.current_step = session[:order_step]

    if params[:back_button]
      order.previous_step
    elsif order.last_step?
      order.save
    else
      order.next_step
    end

    session[:order_step] = order.current_step

    order
  end

  private

  def reset_session_order!
    session.delete(:order_step)
    session[:order_params] = {}
  end

  def build_new_order_items_for(order)
    Item.all.each do |item|
      order.order_items << OrderItem.new(item: item)
    end
  end

  def session_order_params
    session[:order_params]
  end
end