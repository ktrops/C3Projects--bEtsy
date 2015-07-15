class Order < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_many :order_items

  # Validations ----------------------------------------------------------------
  # will there be any validations?
  # you can create an order without filling in the info
  # so will order completion be an update method?

  # Scopes ---------------------------------------------------------------------
end
