class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :theatre
  
  validates :show_time, presence: true
  # validates :show_time, comparison: { greater_than: :Time.now }
  validate :show_time_for_movie

  validates :available_seates, presence: true
  validates :available_seates, numericality: { only_integer: true }
  private
  def show_time_for_movie
    if show_time.present? && show_time < Time.now
      errors.add("show time cannot be in the past time")
    end
  end
end
