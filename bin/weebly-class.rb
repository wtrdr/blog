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
  attr_reader :path, :title, :date

  def initialize(post)
    title = post.css('h2.blog-title')
    href = title.css('a').attribute('href').value

    @path = href.match(/.+\/(.+?)$/)[1]
    @title = title.text
    @date = DateTime
      .strptime(
        post.css('span.date-text').text, # dd/mm/yyyy
        '%d/%m/%Y'
      ).strftime('%Y-%m-%d')
    @contents = post
      .css('.blog-content')
      .children
      .map { |content| re_contents(content) }
  end

  def write_with(paths)
    dir = "content/post"
    FileUtils::mkdir_p dir

    dst = "#{dir}/#{@date}.md"
    File.open(dst, 'w') do |file|
      blog = to_md(paths)
      file.write blog
    end
  end

  private

  def header(paths)
    head = <<EOF
---
title: #{@title}
date: #{@date}
draft: false
tags:
- fixme
keywords:
- fixme
thumbnailImagePosition: left
EOF
    head << @contents.map do |content|
      content.head(path: @path, paths: paths)
    end.reject{|c| c.nil? || c == ''}.join("\n")
    head << "---\n"
    head
  end

  def to_md(paths)
    md = ''
    md << header(paths)
    md << @contents.map do |content|
      content.md(path: @path, paths: paths)
    end.join("\n")
    md
  end
end
