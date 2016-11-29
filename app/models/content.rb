# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  sequence   :text(65535)
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Content < ApplicationRecord
  validates :sequence, presence: true
end
