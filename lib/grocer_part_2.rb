require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  cart.each do |food_item|
    coupon_item = find_item_by_name_in_collection(food_item[:item], coupons)
    if coupon_item && food_item[:count] >= coupon_item[:num]
      food_item[:count] = food_item[:count] - coupon_item[:num]
      cart << ({:item => coupon_item[:item] + " W/COUPON",
                  :price => coupon_item[:cost]/coupon_item[:num],
                  :clearance => food_item[:clearance],
                  :count => coupon_item[:num]
                })
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |food_item|
    if food_item[:clearance] == true 
      food_item[:price] -= (food_item[:price] * 0.2).round(2) 
    end
  end
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  apply_coupons(consolidated_cart, coupons)
  apply_clearance(consolidated_cart)
  total=0
  consolidated_cart.each do |item|
    if item[:count] > 0
      total += item[:price] * item[:count]
    end
  end
  if total > 100
    total -= (total * 0.1).round(2)
  end
  total
end
