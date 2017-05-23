# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  COLORS = %w(Red Blue Green Yellow)

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} must be M or F" }
  validates :color, inclusion: { in: COLORS,
    message: "%{value} must be #{COLORS}" }

  has_many :rental_requests,
    class_name: :CatRentalRequest,
    primary_key: :id,
    foreign_key: :cat_id,
    dependent: :destroy


  def age
    today = Time.current.to_date
    if today.month < birth_date.month ||
      (today.month == birth_date.month && birth_date.day > today.day)

      today.year - birth_date.year - 1
    else
      today.year - birth_date.year
    end
  end

end
