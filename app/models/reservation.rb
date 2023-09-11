class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in,:check_out,:count_people, presence: true
  validate :start_end_check



  def start_end_check
    if check_in == nil
      errors.add(:check_in,"開始日を入力してください")
    elsif checkout_at == nil
      errors.add(:check_out,"終了日を入力してください")
    elsif check_out < check_in
      errors.add(:check_out,"終了日は開始日以降の日付にしてください")
    end
  end

  def days
    days = (check_out - check_in).to_i
  end

  def total_price
    total_price = (days * people_count * room.price)
  end
end
