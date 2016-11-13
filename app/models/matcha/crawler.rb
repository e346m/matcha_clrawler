class Matcha::Crawler
  #Capybara.javascript_driver = :poltergeist
  #Capybara.current_driver = :poltergeist
  Capybara.javascript_driver = :webkit
  def initialize
    @session = Capybara::Session.new :webkit
  end

  def crawling! num
    begin
      access_page num
      paragraphs = get_paragraph
      save_article num, paragraphs
    rescue Exception => e
      print e
    end
  end

  private
  def access_page num
    @session.visit Settings.Domain.send(jadge_country) + num.to_s
  end
  def get_paragraph
    @session.find("div.contents_text").all("p")
  end
  def has_information
    @session.find("div.infomation").text #this is typo in matcha
  end
  def jadge_country
    self.to_s.match(%r{Matcha::(.+?):.+\w})[1].intern
  end
end
