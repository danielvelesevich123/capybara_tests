require 'selenium-webdriver'
require 'capybara'
require 'csv'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end
Capybara.default_max_wait_time = 5
Capybara.default_driver = :selenium
Capybara.javascript_driver = :firefox

browser = Capybara.current_session
url = 'https://onliner.by'
browser.visit url
link = browser.all('h2 a')
link.first.click

result = []
images = []
descriptions = []
titles = []

browser.all('div', class: 'news-tidings__speech').each do |el|
  descriptions.push(el.text[0..200])
end

browser.all('span', class: 'news-helpers_hide_mobile-small').each do |el|
  titles.push(el.text)
end

browser.all('div', class: 'news-tidings__image').each do |el|
  images.push(el['style'])
end

images.length.times do |i|
  result[i] =
    {
      image: images[i],
      title: titles[i],
      description: descriptions[i]
    }
end

file = 'data.csv'
File.open(file, 'w') do |csv|
  result.each do |item|
    csv << "\n#{item[:image]}\n#{item[:title]}\n#{item[:description]}\n\n"
  end
end
