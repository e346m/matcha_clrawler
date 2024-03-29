# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  issue_num  :integer
#  edition    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
  has_one :category
  has_many :contents
  accepts_nested_attributes_for :contents
  validates_uniqueness_of :issue_num, scope: [:edition]
  scope :get_multi_edition, ->id do
    where issue_num: issue_num_from_clue(id)
  end
  class << self
    def issue_num_from_clue id
      Article.find(id).issue_num
    end
    def check_differnt_lines_article
      result = []
      Article.where(edition: "VN").pluck(:id).each do |_id|
        size = []
        Article.get_multi_edition(_id).each do |ins|
          size << ins.contents.size
        end
        result << _id if size[0] != size[1]
      end
      return result
    end
  end
end
