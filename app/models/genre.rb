class Genre < ActiveRecord::Base
  before_validation :generate_slug

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  has_many :characterizations, dependent: :destroy
  has_many :movies, through: :characterizations

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize if name
  end
end
