class Room < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy

    validates :name,:introduction,:address, presence: true
    validates :price , numericality: { greater_than_or_equal_to: 1 }
  

    mount_uploader :image, ImageUploader
  

    def self.ransackable_attributes(auth_object = nil)
      ["address", "name","introduction"]
  end

  #よくわからないけど必要
  def self.ransackable_associations(auth_object = nil)
      ["user"]
  end
end