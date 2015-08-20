class Order < ActiveRecord::Base
  serialize :shipping, Array

  # Associations ---------------------------------------------------------------
  has_many :order_items
  has_many :products, through: :order_items

  # Validations ----------------------------------------------------------------
  US_STATES = [
    ['Alabama', 'AL'],
    ['Alaska', 'AK'],
    ['Arizona', 'AZ'],
    ['Arkansas', 'AR'],
    ['California', 'CA'],
    ['Colorado', 'CO'],
    ['Connecticut', 'CT'],
    ['Delaware', 'DE'],
    ['District of Columbia', 'DC'],
    ['Florida', 'FL'],
    ['Georgia', 'GA'],
    ['Hawaii', 'HI'],
    ['Idaho', 'ID'],
    ['Illinois', 'IL'],
    ['Indiana', 'IN'],
    ['Iowa', 'IA'],
    ['Kansas', 'KS'],
    ['Kentucky', 'KY'],
    ['Louisiana', 'LA'],
    ['Maine', 'ME'],
    ['Maryland', 'MD'],
    ['Massachusetts', 'MA'],
    ['Michigan', 'MI'],
    ['Minnesota', 'MN'],
    ['Mississippi', 'MS'],
    ['Missouri', 'MO'],
    ['Montana', 'MT'],
    ['Nebraska', 'NE'],
    ['Nevada', 'NV'],
    ['New Hampshire', 'NH'],
    ['New Jersey', 'NJ'],
    ['New Mexico', 'NM'],
    ['New York', 'NY'],
    ['North Carolina', 'NC'],
    ['North Dakota', 'ND'],
    ['Ohio', 'OH'],
    ['Oklahoma', 'OK'],
    ['Oregon', 'OR'],
    ['Pennsylvania', 'PA'],
    ['Puerto Rico', 'PR'],
    ['Rhode Island', 'RI'],
    ['South Carolina', 'SC'],
    ['South Dakota', 'SD'],
    ['Tennessee', 'TN'],
    ['Texas', 'TX'],
    ['Utah', 'UT'],
    ['Vermont', 'VT'],
    ['Virginia', 'VA'],
    ['Washington', 'WA'],
    ['West Virginia', 'WV'],
    ['Wisconsin', 'WI'],
    ['Wyoming', 'WY']
  ]

  US_STATE_LETTER_CODES = US_STATES.collect { |full_name, abbrev| abbrev }

  validates :status, inclusion: { in: %w(pending paid complete cancelled),
    message: "That is not a valid order status" }
  validates :cc_number, numericality: { only_integer: true },
    length: { in: 15..16 }, on: :update
  validates :address1, :city, :state, :cc_expiration, presence: true, on: :update
  validates :state, inclusion: { in: US_STATE_LETTER_CODES }, on: :update
  validate :expiration_date_cannot_be_in_the_past, on: :update
  validates :cc_cvv, numericality: { only_integer: true }, length: { is: 3 }, on: :update
  validates :billing_zip, numericality: { only_integer: true }, length: { is: 5 }, on: :update
  validates :mailing_zip, numericality: { only_integer: true }, length: { is: 5 }, on: :update

  def expiration_date_cannot_be_in_the_past
    if cc_expiration && cc_expiration < Date.today
      errors.add(:cc_expiration, "cannot be in the past.")
    end
  end

  # Scopes ---------------------------------------------------------------------
  def subtotal
    order_items.inject(0) { |sum, item| sum += (item.product.price * item.quantity) }
  end

  # Custom ---------------------------------------------------------------------
  def mark_shipped!
      toggle!(:shipped)
  end

  def final_total
    order_items.inject(0) { |sum, item| sum += (item.item_total) }
  end

end
