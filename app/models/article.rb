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
end
