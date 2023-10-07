class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in,:check_out,:count_people, presence: true
 
  validate :start_finish_check
  validate :date_before_start
 
  def days
    days = (check_out - check_in).to_i
  end


  def total_price
    total_price = (days * count_people * room.price)
  end

 
  def date_before_start
    return if check_in.blank?
    errors.add(:check_in, "は今日以降のものを選択してください") if check_in < Date.today
  end
end
  def start_finish_check
    unless check_in.nil? || check_out.nil?
      errors.add(:check_out, "はチェックイン日より遅い日程を選択してください") if check_in >= check_out
    end
  end

