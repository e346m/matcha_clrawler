class Matcha::Crawler
  Capybara.javascript_driver = :webkit
  def initialize
    @session = Capybara::Session.new :webkit
    @country = jadge_country.upcase
  end

  def crawling! num
    begin
      access_page num
      paragraphs = get_paragraph
      save_article num, paragraphs
    rescue Exception => e
      print e
    rescue Capybara::ElementNotFound => e
      return if not_found?
      take_a_screenshot
      p "preventing page: #{num}"
    end
  end

  private
  def access_page num
    @session.visit Settings.Domain.send(@country) + num.to_s
  end
  def get_paragraph
    @session.find("div.contents_text").all("p")
  end
  def has_information
    @session.find("div.infomation").text #this is typo in matcha
  end
  def not_found?
    @session.has_css?(".not_found")
  end
  def jadge_country
    self.to_s.match(%r{Matcha::(.+?):.+\w})[1].intern
  end
  def take_a_screenshot
    @session.save_screenshot Rails.root.join "tmp", random_string+".png"
  end
  def save_article num, parag
    article = Article.new ({
      issue_num: num,
      edition: @country,
    })
    sentence = parag.reject do |row|
      row.text.blank?
    end
    article.contents_attributes = sentence.map do |text|
      {sequence: text}
    end
    article.save
  end
end
