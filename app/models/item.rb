# == Schema Information
#
# Table name: items
#
#  id              :bigint           not null, primary key
#  ai_detected     :boolean
#  detected_at     :datetime
#  expiration_date :date
#  name            :string
#  quantity        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # Validations
  validates :name, presence: true
  validates :quantity, numericality: { greater_than: 0 }, allow_nil: true

  # Scopes
  scope :expiring_soon, -> { where("expiration_date <= ?", 3.days.from_now).order(:expiration_date) }
  scope :ai_detected, -> { where(ai_detected: true) }
  scope :manually_added, -> { where(ai_detected: [false, nil]) }

  # Default values
  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.quantity ||= 1
    self.ai_detected = false if ai_detected.nil?
  end
end
