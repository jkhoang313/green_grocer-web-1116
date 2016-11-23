def consolidate_cart(cart)
  # code here
  counter = {}
  cart.each do |element|
    element.each do |name, details|
      counter[name] = details if counter[name] == nil
      if counter[name][:count] == nil
        counter[name][:count] = 1
      else
        counter[name][:count] += 1
      end
    end
  end
  counter
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] != nil && cart[name][:count] >= coupon[:num]
      count = 0
      until cart[name][:count] < coupon[:num]
        count += 1
        cart[name][:count] -= coupon[:num]
        cart[name + " W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[name][:clearance],
          :count => count
        }
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |food, details|
    if details[:clearance] == true
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  total = 0
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each do |food, details|
    total += details[:price]*details[:count] unless details[:count] == 0
  end
  total > 100 ? total*0.9 : total
end
