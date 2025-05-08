class GeneratedThumbnail < ApplicationRecord
  has_one_attached :sketch

  validate :sketch_size_and_format

  def sketch_size_and_format
    return unless sketch.attached?

    if sketch.byte_size > 25.megabytes
      errors.add(:sketch, "must be under 25MB")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(sketch.content_type)
      errors.add(:sketch, "must be a JPG or PNG")
    end
  end
end
