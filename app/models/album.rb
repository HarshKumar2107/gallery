class Album < ApplicationRecord
	scope :published, -> { where(published: true)}
  scope :unpublished, -> { where(published: false)}
  
  after_save do
    if self.published_previously_changed?
       UserMailer.publish_msg(user.email).deliver_later if published?
    end
  end

	belongs_to :user
	has_and_belongs_to_many :tags

	has_one_attached :cover
	has_many_attached :images

	validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  def tagged=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(album_tags: name.strip).first_or_create!
    end
  end

  def tagged
    tags.map(&:album_tags).join(", ")
  end
end