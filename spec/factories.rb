FactoryGirl.define do
  factory :order do
    status "pending"
  end

  factory :order_item do
    quantity 4
  end

  factory :product do
    name "toy"
    price 10
    stock 100
  end


  # factory :book do
  #   name "House of Leaves"
  #   author "Mark Z. Danielewski"
  #   description "House of Leaves is the debut novel by the American author Mark Z. Danielewski, published by Pantheon Books. The novel quickly became a bestseller following its release on March 7, 2000. It was followed by a companion piece, The Whalestoe Letters"
  # end
end