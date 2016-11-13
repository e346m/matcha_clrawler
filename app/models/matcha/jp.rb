class Matcha::Jp < Matcha::Crawler
  def initialize
    super
  end

  def save_article num, parag
    parag.each.with_index(1) do |row, index|
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
