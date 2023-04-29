class Story < ApplicationRecord
include AASM
extend FriendlyId
friendly_id :slug_candidate , use: :slugged
acts_as_paranoid

  belongs_to :user
  has_many :comments
  has_one_attached :cover_image
  validates :title, presence: true
  scope :published_stories, -> {published.with_attached_cover_image.order(created_at: :desc).includes(:user)}

  aasm(column: 'status', no_direct_assignment: true) do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  private

  def slug_candidate
    [
      :title,
      [:title, SecureRandom.hex[0, 8]]
    ]
  end
end
