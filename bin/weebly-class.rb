def re_contents(content)
  element = content.name
  clazz = content.attr('class')
  if clazz =~ /.*wsite-content-title.*/
    return Title.new(content)
  elsif clazz =~ /.*wsite-youtube.*/
    return Youtube.new(content)
  elsif clazz =~ /.*wsite-spacer.*/
    return Spacer.new(content)
  elsif clazz =~ /.*wsite-image.*/
    return Image.new(content)
  elsif clazz =~ /.*paragraph.*/
    return Paragraph.new(content)
  elsif clazz =~ /.*imageGallery.*/
    return ImageGallery.new(content)
  elsif clazz =~ /.*styled-hr.*/
    return Hr.new(content)
  elsif element == 'blockquote'
    return Blockquote.new(content)
  elsif clazz.nil?
    return Contents.new(
      content
        .children
        .map { |c| re_contents(c) }
    )
  else
    raise "Cannot create for: #{clazz}"
  end
end

class Weebly
  def initialize(post)
    title = post.css('h2.blog-title')
    href = title.css('a').attribute('href').value

    @path = href.match(/.+\/(.+?)$/)[1]
    @title = title.text
    @date = post.css('span.date-text').text # dd/mm/yyyy
    @contents = post
      .css('.blog-content')
      .children
      .map { |content| re_contents(content) }
  end

  def to_md
    md = ''
    md << "# #{@title}\n"
    md << @contents.map do |content|
      content.md(path: @path)
    end.join("  \n")
    md
  end
end
