class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  # 数据验证
  validates_presence_of :title, :description, :image_url, :price
  validates_uniqueness_of :title
  validates :title, length: { minimum: 10, too_short: 'length was too short' }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  private 

  # 确保仍有商品在引用此产品 
  def ensure_not_referenced_by_any_line_item 
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
