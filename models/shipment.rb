class Shipment < ActiveRecord::Base
  belongs_to :order
  
  def auth_by_code_and_user(auth_code,user)
    order_ids = []
    user.orders.each do |order|
      order_ids << order.id if order.state == "address"
    end

    auth = self.find(:first, :conditions => ["auth_code=? and order_id in (?)", auth_code, order_ids.join(",")])
  end
end
