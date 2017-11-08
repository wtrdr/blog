def re_contents(content)
  element = content.name
  clazz = content.attr('class')
  if clazz =~ /.*wsite-content-title.*/
    Title.new(content)
  elsif clazz =~ /.*wsite-youtube.*/
    Youtube.new(content)
  elsif clazz =~ /.*wsite-spacer.*/
    Spacer.new(content)
  elsif clazz =~ /.*wsite-image.*/
    Image.new(content)
  elsif clazz =~ /.*paragraph.*/
    Paragraph.new(content)
  elsif clazz =~ /.*imageGallery.*/
    ImageGallery.new(content)
  elsif clazz =~ /.*styled-hr.*/
    Hr.new(content)
  elsif element == 'blockquote'
    Blockquote.new(content)
  elsif clazz.nil?
    content
      .children
      .map { |c| re_contents(c) }
  else
    raise "Cannot create for: #{clazz}"
  end
end

class Weebly
  def initialize(post)
    @title = post.css('h2.blog-title').text
    @date = post.css('span.date-text').text # dd/mm/yyyy
    @contents = post
      .css('.blog-content')
      .children
      .map { |content| re_contents(content) }
  end

  def to_md
  end
end
