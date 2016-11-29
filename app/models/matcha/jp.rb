class Matcha::Jp < Matcha::Crawler
  def initialize
    super
  end

  def save_article num, parag
    parag.each do |row|
      article = Article.new ({
        country: "jp",
        text: row.text
      })
      article.save
    end
  end
end
