class Content
  def initialize(content)
    @content = content
  end
  def md(path: ''); end
end

class Contents < Content
  def md(path: '')
    return '' if @content == []
    @content.map do |c|
      c.md(path: path)
    end.join("  \n")
  end
end

class Title < Content
  def md(path: '')
    # "## #{@content.text}"
  end
end

class Youtube < Content
  def md(path: '')
    # src = @content.css('iframe').attribute('src').value
    # id = src.match(/.+\/(.+)\?/)[1]
    # "{{< youtube #{id} >}}"
  end
end

class Spacer < Content
  def md(path: '')
    "  "
  end
end

class Image < Content
  def md(path: '')
    p @content
    p path
    FileUtils::mkdir_p 'foo/bar'
    src = @content.css('img').attribute('src').value
    filename = src.match(/.+\/(.+?)$/)[1]
    "{{< image classes='' src='/testimg.jpg' thumbnail='/testimg.jpg' title='' >}}"
  end
end

class Paragraph < Content
end

class ImageGallery < Content
end

class Hr < Content
end

class Blockquote < Content
end
