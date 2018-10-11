class User < ApplicationRecord
  has_secure_password

  # Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
  validates :email, presence: true, uniqueness: true

	has_many :balance_adjustments
  has_many :withdrawals
  has_many :sessions

  def create_session!
    Session.create!(user: self)
  end

  def admin?
    true
  end

  def balances
    balance_adjustments.group(:coin_id).sum(:amount).as_json
  end

end
