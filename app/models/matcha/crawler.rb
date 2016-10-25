class Matcha::Crawler
  #Capybara.javascript_driver = :poltergeist
  #Capybara.current_driver = :poltergeist
  Capybara.javascript_driver = :webkit
  MATCHA_DOMEIN = "https://matcha-jp.com/"
  def initialize
    @session = Capybara::Session.new :webkit
  end
  def save_article country, num
    access_page country, num
    paragraphs = get_paragraph

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
  def access_page country, num
    @session.visit MATCHA_DOMEIN + "#{country}/#{num}"
  end
  def get_paragraph
    @session.find("div.contents_text").all("p")
  end
  def has_information
    @session.find("div.infomation").text #this is typo in matcha
  end
end
