# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

orders = [
  { status: "paid", email: "joe@mail.com", cc_name: "Joe Smoe", cc_number: "0000123456781234", #1
    cc_cvv: 567, billing_zip: 98740, shipped: false, address1: "123 Main St",
    address2: "apt #2", city: "Kent", state: "WA", mailing_name: "Joe Smoe",
    mailing_zip: 98740 },
  { status: "cancelled", email: "holly@mail.com", cc_name: "Holly Golightly", cc_number: "0000123456788765", #2
    cc_cvv: 341, billing_zip: 89754, shipped: true, address1: "123 Oak Lane",
    address2: nil, city: "Lavender", state: "OR", mailing_name: "Holly Golightly",
    mailing_zip: 89543 },
  { status: "complete", email: "eggplant@mail.com", cc_name: "Eggplant Kalamazoo", cc_number: #3
  "0000123456785678",
    cc_cvv: 341, billing_zip: 12345, shipped: false, address1: "123 Armadillo Rd",
    address2: nil, city: "Petunia", state: "ID", mailing_name: "Eggplant Kalamazoo",
    mailing_zip: 12345 },
  { status: "cancelled", email: "zorak@mail.com", cc_name: "Zorak", cc_number: #4
  "0000123456785678",
    cc_cvv: 452, billing_zip: 67189, shipped: false, address1: "123 Space Way",
    address2: nil, city: "Nope", state: "AK", mailing_name: "Zorak",
    mailing_zip: 67819 },
  { status: "paid", email: "sg@mail.com", cc_name: "Space Ghost", cc_number: #5
  "0000123456785678",
    cc_cvv: 452, billing_zip: 67189, shipped: false, address1: "123 Space Way",
    address2: nil, city: "Nope", state: "AK", mailing_name: "Space Ghost",
    mailing_zip: 67819 },
  { status: "complete", email: "brak@mail.com", cc_name: "Brak", cc_number: #6
  "0000123456785678",
    cc_cvv: 452, billing_zip: 54712, shipped: false, address1: "123 Space Way",
    address2: nil, city: "HiMom", state: "OH", mailing_name: "Brak",
    mailing_zip: 54712 },
  { status: "complete", email: "brak@mail.com", cc_name: "Brak", cc_number: #7
  "0000123456785678",
    cc_cvv: 452, billing_zip: 54712, shipped: false, address1: "123 Space Way",
    address2: nil, city: "HiMom", state: "OH", mailing_name: "Brak",
    mailing_zip: 54712 },
  { status: "paid", email: "moltar@mail.com", cc_name: "Moltar", cc_number: #8
  "0000123456785678",
    cc_cvv: 452, billing_zip: 41237, shipped: false, address1: "123 Space Way",
    address2: nil, city: "Lava City", state: "NM", mailing_name: "Moltar",
    mailing_zip: 41237 }
]

orders.each do |order|
  Order.create(order)
end

users = [
  { username: "Sue Boo", email: "sue.boo@example.com", #1
    password: "password", password_confirmation: "password" },
  { username: "Kate Plate", email: "kate.plate@example.com", #2
    password: "password", password_confirmation: "password" },
  { username: "Bob Cobb", email: "bob.cobb@example.com", #3
    password: "password", password_confirmation: "password" }
]

users.each do |user|
  User.create(user)
end

products = [
  { name: "Principal's Email Address", price: 1000, #1
    description: "a verified principal's email address",
    active: true, photo_url: "dunecat.jpg", length: 12, width: 10, height: 2, stock: 10, user_id: 1 },
  { name: "CEO's password", price: 20000, #2
    description: "Password to CEO's OnePass Account",
    active: true, photo_url: "dunecat.jpg", length: 12, width: 10, height: 2, stock: 5, user_id: 1 },
  { name: "MRA's Reddit Password", price: 500, #3
    description: "embarrass a jerk in his online community",
    active: true, photo_url: "dunecat.jpg", length: 12, width: 10, height: 2, stock: 3, user_id: 2 },
  { name: "The Rock's Home Address", price: 10000, #4
    description: "all you need to stalk your fav",
    active: true, photo_url: "dunecat.jpg", length: 12, width: 10, height: 2, stock: 10, user_id: 2 },
  { name: "Random Xbox Live Account", price: 1000, #5
    description: "everything you need to play games and rack up fees on another user's account", active: true, photo_url: "troll.png", length: 12, width: 10, height: 2, stock: 20, user_id: 3 },
  { name: "Xbox Live Password for a Given User", price: 5000, #6
    description: "everything you need to play games, rack up fees or troll with the suer of your choice's account", active: true, photo_url: "troll.png", length: 12, width: 10, height: 2, stock: 4, user_id: 3 },
  { name: "WOW level 100 Beast Master Hunter", price: 8000, #7
    description: "Max level account comes with 20k gold and 45 mounts, ilvl 652", active: true, photo_url: "hunter.jpg", length: 12, width: 10, height: 2, stock: 1, user_id: 3 },
  { name: "Whitehouse.gov Email Address", price: 10000, #8
    description: "Send emails from an official Whitehouse account watch the chaos and hilarity ensue.", active: true, photo_url: "white-house.png", length: 12, width: 10, height: 2, stock: 5, user_id: 1 },
  { name: "Random Sony Playstation Account Information", price: 1000, #9
    description: "Troll, rack up fees or steal games using this account password.", active: true, photo_url: "troll.png", length: 12, width: 10, height: 2, stock: 12, user_id: 3 },
  { name: "Level 30 League of Legends Account", price: 3000, #10
    description: "Comes with 30,000 IP", active: true, photo_url: "lol.jpg", length: 12, width: 10, height: 2, stock: 8, user_id: 3 },
    { name: "Ashley Madison Administrative Account", price: 25000, description:
    "Go rogue and instate your own vigilante moral justice or blackmail cheaters, either way you win!", active: true, photo_url: "ashley.jpg", length: 12, width: 10, height: 2, stock: 1, user_id: 2} #11
]

products.each do |product|
  Product.create(product)
end

reviews = [
  { rating: 4, review_text: "great secret!", product_id: 1 },
  { rating: 3, review_text: "lousy secret", product_id: 2 },
  { rating: 1, review_text: "gross, i can't even", product_id: 3 },
  { rating: 5, review_text: "awesome, love hacking jerks", product_id: 3 },
  { rating: 2, review_text: "stalking is the best!", product_id: 4 },
]

reviews.each do |review|
  Review.create(review)
end

#orders up to 8
order_items = [
  { quantity: 1, item_total: 1000, product_id: 1, order_id: 1 },
  { quantity: 1, item_total: 500, product_id: 3, order_id: 2 },
  { quantity: 2, item_total: 40000, product_id: 2, order_id: 3 },
  { quantity: 2, item_total: 20000, product_id: 4, order_id: 3 },
  { quantity: 1, item_total: 1000, product_id: 5, order_id: 4 },
  { quantity: 3, item_total: 1500, product_id: 3, order_id: 4 },
  { quantity: 1, item_total: 1000, product_id: 1, order_id: 4 },
  { quantity: 2, item_total: 20000, product_id: 8, order_id: 5 },
  { quantity: 1, item_total: 8000, product_id: 7, order_id: 6 },
  { quantity: 1, item_total: 1000, product_id: 5, order_id: 6 },
  { quantity: 2, item_total: 10000, product_id: 6, order_id: 7 },
  { quantity: 4, item_total: 12000, product_id: 10, order_id: 8 },
  { quantity: 1, item_total: 1000, product_id: 9, order_id: 8 }
]

order_items.each do |order_item|
  OrderItem.create(order_item)
end

categories = [
  {name: "email address"},
  {name: "home address"},
  {name: "contact info"},
  {name: "password"},
  {name: "state secret"},
  {name: "personal secret"},
  {name: "celebrity"},
  {name: "financial"},
  {name: "educational"}
]

categories.each do |category|
  Category.create(category)
end

product_categories = [
  {product_id: 1, category_id: 1},
  {product_id: 1, category_id: 9},
  {product_id: 1, category_id: 3},
  {product_id: 2, category_id: 4},
  {product_id: 2, category_id: 8},
  {product_id: 3, category_id: 4},
  {product_id: 3, category_id: 6},
  {product_id: 4, category_id: 2},
  {product_id: 4, category_id: 6},
  {product_id: 4, category_id: 7},
  {product_id: 4, category_id: 3}
]

product_categories.each do |product_category|
  ProductCategory.create(product_category)
end
