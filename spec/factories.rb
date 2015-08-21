FactoryGirl.define do
  factory :user do
    username "JoeJoe"
    email "joe@joe.com"
    password "hello"
  end

  factory :order do
    status "pending"
    email "joe@mail.com"
    cc_name "Joe Smoe"
    cc_number "0000123456781234"
    cc_cvv 567
    billing_zip 98740
    shipped false
    address1 "123 Main St"
    address2 "apt #2"
    city "Kent"
    state "WA"
    mailing_name "Joe Smoe"
    mailing_zip 98740
  end


  factory :order_item do
    quantity 4
  end

  factory :product do
    name "toy"
    price 10
    stock 100
    length 2
    width 2
    height 2
    weight 2
  end


  # factory :book do
  #   name "House of Leaves"
  #   author "Mark Z. Danielewski"
  #   description "House of Leaves is the debut novel by the American author Mark Z. Danielewski, published by Pantheon Books. The novel quickly became a bestseller following its release on March 7, 2000. It was followed by a companion piece, The Whalestoe Letters"
  # end
end
