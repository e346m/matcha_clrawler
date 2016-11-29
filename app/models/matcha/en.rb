class Matcha::En < Matcha::Crawler
  def initialize
    super
  end

  #TODO 何か取れていない情報があったのと行数がおかしかった問題
  def save_article num, paragraphs
    paragraphs.each do |row|
      article = Article.new ({
        country: "en",
        text: row.text
      })
      article.save
    end
  end
end
