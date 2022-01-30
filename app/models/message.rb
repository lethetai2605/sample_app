class Message < ApplicationRecord
  # frozen_string_literal: true
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_one_attached :image
  has_one_attached :document

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :content, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }
  validates :document, content_type: { in: %w[application/msword application/pdf application/zip],
                                       message: 'must be a PDF or a DOC file' },
                       size: { less_than: 5.megabytes,
                               message: 'should be less than 5MB' }

  scope :pair_messages, ->(sender_id, receiver_id) {
    where(sender_id: sender_id, receiver_id: receiver_id)
      .or(Message.where(sender_id: receiver_id, receiver_id: sender_id))
  }
  scope :new_chats, -> { where("created_at BETWEEN ? AND ?", 1.day.ago.beginning_of_day, 1.day.ago.end_of_day) }

  after_create_commit {
    MessageBroadcastJob.perform_later(self)
  }

  def display_image
    image
  end
end
