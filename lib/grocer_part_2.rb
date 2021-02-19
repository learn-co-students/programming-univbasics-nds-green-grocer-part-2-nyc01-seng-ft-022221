require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)

  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

if(coupons != nil && coupons.size > 0)


    coupons.each do
      |coupon|
      #binding.pry

      cart.each do
        |item|

        if(coupon[:item] == item[:item])
          if(coupon[:num] <= item[:count])  #is this what "minimum" refers to?
            item[:count] -= coupon[:num]
      #      binding.pry
            new_thing = {}
            new_thing[:item] = "#{coupon[:item]} W/COUPON"
            new_thing[:price] = (coupon[:cost]/coupon[:num]).round(2)
      #      binding.pry
            #new_thing[:price] = new_thing[:price].round(2)
            new_thing[:clearance] = item[:clearance]
            new_thing[:count] = coupon[:num]
      #      binding.pry
            cart.push(new_thing)
          end
        end
      end
    end
end
  return cart

end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  cart.each do
    |item|
    if(item[:clearance])
      item[:price] *= 0.8
      item[:price] = item[:price].round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)

  final = consolidate_cart(cart)
  final = apply_coupons(final, coupons)
  final = apply_clearance(final)
  total = 0

  final.each do
    |item|
    total += item[:price]*item[:count]
  end

  return total > 100 ? (total*0.9).round(2) : total
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end

thing = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]

otherthing = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00}
]

xy = [{:item => "BEER", :price => 13.00, :clearance => false}, {:item => "BEER", :price => 13.00, :clearance => false}, {:item => "BEER", :price => 13.00, :clearance => false}
]

y = [ {:item => "BEER", :num => 2, :cost => 20.00},  {:item => "BEER", :num => 2, :cost => 20.00}]

puts checkout(xy, y)
