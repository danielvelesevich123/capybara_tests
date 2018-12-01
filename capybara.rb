require_relative 'lib/page_with_news'
require_relative 'lib/writer'

page = PageWithNews.set_page('https://people.onliner.by')

result = []
images = PageWithNews.find_info_in_atribute(page, 'div', 'news-tidings__image', 'style')
descriptions = PageWithNews.find_info_in_tag(page, 'div', 'news-tidings__speech')
titles = PageWithNews.find_info_in_tag(page, 'span', 'news-helpers_hide_mobile-small')

images.length.times do |i|
  result[i] =
    {
      image: images[i],
      title: titles[i],
      description: descriptions[i]
    }
end

file = 'data.csv'
Writer.write_into_file(file, result)
