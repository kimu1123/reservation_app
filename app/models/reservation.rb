class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in,:check_out,:count_people, presence: true
  validates :count_people, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validate :start_finish_check

 
  def days
    days = (check_out - check_in).to_i
  end


  def total_price
    total_price = (days * count_people * room.price)
  end


  def start_finish_check
    unless check_in.nil? || check_out.nil?
      errors.add(:check_out, "はチェックイン日より遅い日程を選択してください") if check_in >= check_out
    end
  end
end
