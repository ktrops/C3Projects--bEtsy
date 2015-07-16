require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validation presence: true" do
    context "valid" do
      it "creates a valid review" do
        review = Review.create(rating: 4)

        expect(review).to be_valid
        expect(review.errors.keys).to_not include(:rating)
      end
    end

    context "invalid" do
      it "does not create a review" do
        review = Review.create(rating: nil)

        expect(review).to_not be_valid
        expect(review.errors.keys).to include(:rating)
      end
    end
  end

  describe "validation numercality: 0 <= integer >= 5" do
    context "invalid" do
      it "does not create a review" do
        review = Review.create(rating: 6)

        expect(review).to_not be_valid
        expect(review.errors.keys).to include(:rating)
      end

      it "does not create a review" do
        review = Review.create(rating: 4.5)

        expect(review).to_not be_valid
        expect(review.errors.keys).to include(:rating)
      end
    end
  end
end
