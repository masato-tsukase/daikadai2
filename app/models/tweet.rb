class Tweet < ActiveRecord::Base
    validates :title, presence: true
    validates :content, presence: true
    validates :content, length: { maximum: 255 }

    belongs_to :user
    has_many :comments, dependent: :destroy

    mount_uploader :image, ImageUploader
end
