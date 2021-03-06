base_uri 'madonna-av.com'

register_product(
  /^(JUC|JUFD|JUX|OBA|URE)-?(\d{3})$/i,
  '/works/-/detail/=/cid=#{$1.downcase}#{$2}',
)

private

def self.parse_product_html(html)
  specs = Utils.hash_from_dl(html.css('#column_contents > div > div.right_contents > dl'))
  {
    actresses:       specs['出演女優'].css('a').map(&:text),
    cover_image:     html.at_css('#column_contents > div > div.left_contents > div.pack > a')['href'],
    description:     html.css('#column_contents > div > div.left_contents > p').text,
    directors:       specs['監督'].text.split,
    genres:          specs['ジャンル'].text.split,
    maker:           'Madonna',
    movie_length:    specs['収録時間'].text.remove('DVD'),
    release_date:    specs['発売日'].text.remove('DVD'),
    sample_images:   html.css('#column_contents > div > div.left_contents > div.photo > ul > li > a').map { |a| a['href'] },
    thumbnail_image: html.at_css('#column_contents > div > div.left_contents > div.pack > a > img')['src'],
    title:           html.css('#column_contents > h2').text,
  }
end
