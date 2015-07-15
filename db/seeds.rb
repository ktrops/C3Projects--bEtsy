# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

orders = [
        {status: "pending", email: "joe@mail.com", cc_name: "Joe Smoe", cc_number: "465732189057685", cc_cvv: 567, billing_zip: 98740, shipped: false, 
         address1: "123 Main st", address2: "apt #2", city: "Kent", state: "WA", mailing_zip: 98740},
        {status: "shipped", email: "holly@mail.com", cc_name: "Holly Golightly", cc_number: "5764832967986543", cc_cvv: 341, billing_zip: 89754, shipped: true, 
         address1: "123 Oak Lane", address2: nil, city: "Lavender", state: "OR", mailing_zip: 89543}
]

orders.each do |order|
  Order.create(order)
end
