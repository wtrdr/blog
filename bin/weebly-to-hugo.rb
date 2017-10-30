require "net/http"
require "uri"
require "openssl"
require "rexml/document"
require "nokogiri"

def get_html(url)
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  https.start
  https.get(url.path).body.delete!("\n").delete!("\t")
end

def main
  # (0..5).map do |i|
  (0..0).map do |i|
    url = URI.parse("https://wataridori.weebly.com/blog/previous/#{i}")
    p ">> URL: #{url}"
    html = Nokogiri::HTML.parse get_html(url)
    nodes = html.css 'div.blog-post'
    nodes.each do |node|
      text = node.css('div.blog-header')
      p text
    end
    # p posts
    p ">>>> POSTS: #{nodes.size}"
  end
end


p "> Start Convert."
main
p "> Finish Convert."
