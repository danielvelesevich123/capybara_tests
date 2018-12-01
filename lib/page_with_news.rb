require 'selenium-webdriver'
require 'capybara'
class PageWithNews
  class << self
    def set_page(url)
      Capybara.default_driver = :selenium
      browser = Capybara.current_session
      browser.visit url
      browser
    end

    def find_info_in_tag(page, tag, class_attribute)
      info = []
      page.all(tag, class: class_attribute).each do |el|
        info.push(el.text[0..200])
      end
      info
    end

    def find_info_in_atribute(page, tag, class_attribute, attribute)
      info = []
      page.all(tag, class: class_attribute).each do |el|
        info.push(el[attribute])
      end
      info
    end
  end
end