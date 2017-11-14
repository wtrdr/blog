$:.unshift File.dirname(__FILE__)  # ロードパスにカレントディレクトリを追加
require "net/http"
require "uri"
require "openssl"
require "rexml/document"
require "nokogiri"
require 'fileutils'

require "weebly-class.rb"
require "weebly-html.rb"

def get_html(url)
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  https.verify_mode = OpenSSL::SSL::VERIFY_NONE
  https.start
  https
    .get(url.path)
    .body
    .gsub!(/(\r\n|\r|\n)/, '')
    .gsub!(/(\t)/, '')
    .gsub!(/>\s+</, '><')
end

def main
  weeblies = (1..5).map do |i|
  # weeblies = (1..1).map do |i|
    Nokogiri::HTML
      .parse(get_html(URI.parse("https://wataridori.weebly.com/blog/previous/#{i}")))
      .css('div.blog-post')
      .map { |post| Weebly.new(post) }
  end.flatten
  p ">> Total posts: #{weeblies.size}"
  weeblies.each do |weebly|
    puts weebly.to_md
    raise
  end
end

p "> Start Convert."
main
p "> Finish Convert."
