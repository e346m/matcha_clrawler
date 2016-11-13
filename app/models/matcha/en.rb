class Matcha::En < Matcha::Crawler
  def initialize
    super
  end

  #TODO 何か取れていない情報があったのと行数がおかしかった問題
  def save_article num, paragraphs
    paragraphs.each.with_index(1) do |row, index|
      article = Article.new ({
        issue_num: num,
        country: country,
        row_num: index,
        text: row.text
      })
      article.save
    end
  end
end
