class Client < ApplicationRecord
  has_and_belongs_to_many :invoices

  validates :fiscal_id, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
