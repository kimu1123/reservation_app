class Room < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy

    validates :name,:introduction,:price,:address, presence: true
    validates :price, numericality: true

    mount_uploader :image, ImageUploader
end

