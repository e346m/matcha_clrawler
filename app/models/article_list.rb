require "csv"
class Array
  def safe_transpose
    result = []
    max_size = self.max { |a, b| a.size <=> b.size }.size
    max_size.times do |i|
      result[i] = Array.new(self.first.size)
      self.each_with_index { |r, j| result[i][j] = r[i] }
    end
    result
  end
end
class ArticleList
  include ActiveModel::Model
  class << self
    def output_csv
      klass = Article
      diff_ids = klass.check_differnt_lines_article
        diff_ids.each do |id|
          set_article = klass.get_multi_edition id
          num = set_article.first.issue_num
          vn_s = set_article.first.contents.map(&:sequence)
          jp_s = set_article.last.contents.map(&:sequence)
          CSV.open "#{Rails.root}/tmp/article#{num}.csv", "wb" do |f_csv|
          [vn_s, jp_s].safe_transpose.each do |s|
            f_csv << s
          end
        end
      end
    end
  end
end
