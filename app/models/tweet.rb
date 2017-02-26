class Tweet < ActiveRecord::Base
    validates :title, presence: true
    validates :content, presence: true
    validates :content, length: { maximum: 255 }

    belongs_to :user

    mount_uploader :image, ImageUploader
end
