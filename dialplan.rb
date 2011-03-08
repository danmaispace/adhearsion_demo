demo {
  play 'demo-welcome'
  caller_num = get_variable("CALLERID(num)")
  caller_num = caller_num.last(10)
  puts caller_num
  #begin
    @caller = User.find(:first, :conditions => ["login=?", caller_num])
  #rescue
  #  hangup
  #end
  if @caller
    +authorize
  else
    +order
  end
}

order {
  puts 'order'
  order_code = input :timeout => 30.seconds, :play => 'demo-exception1'
  3.times do |i|
    puts "order_code" + order_code
    @order = Order.find(:first, :conditions => ["number=?", order_code])
    
    if @order
      +authorize
      break
    else
      case i
      when 0
        puts '0'
        order_code = input :timeout => 30.seconds, :play => 'demo-exception1.1'
        next
      when 1
        puts '1'
        order_code = input :timeout => 30.seconds, :play => 'demo-exception1.1.1'
        next
       when 2
        puts '2'
        play 'demo-exception1.1.1.1'        
      end
    end
  end
  play 'demo-thanks'
  hangup
}

authorize {
  puts 'authorize'
  auth_code = input :timeout => 30.seconds, :play => 'demo-input-auth-code'
  3.times do |i|
    puts "auth_code" + auth_code
    if @order 
      auth = Shipment.find(:first, :conditions => ["auth_code=? and order_id=?", auth_code, @order.id])
    else
      order_ids = []
      @caller.orders.select{|o| o.state == 'address'}.each do |order|
          order_ids << order.id
      end
      auth = Shipment.find(:first, :conditions => ["auth_code=? and order_id in (?)", auth_code, order_ids.join(",")])
    end
    
    if auth
      auth.auth_code_confirm_at = Time.now()
      if auth.save
        play 'demo-accepted', 'demo-order-total', auth.order.total, 'demo-authorized'

        unless @caller
            play 'demo-exception3.part1'
            pressed = input :accept_key => "*", :timeout => 5.seconds, :play => 'demo-exception3.part2' 
            puts pressed
            if pressed == "#"
                # send email instruction to user
                play 'demo-exception3.1'
            end
        end
      end
      break
    else
      case i
      when 0
        auth_code = input :timeout => 30.seconds, :play => 'demo-exception2'
        next
      when 1
        auth_code = input :timeout => 30.seconds, :play => 'demo-exception2.1'
        next
      when 2
        play 'demo-exception2.1.1'
      end
    end
  end  
  play 'demo-thanks'
  hangup
}
