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
    # "  "
  end
end

class Image < Content
  def md(path: '')
    # text = @content.text

    # src = @content.css('img').attribute('src').value.gsub(/\?.+$/, '')
    # filename = src.match(/.+\/(.+?)$/)[1]

    # store = "static/#{path}"
    # FileUtils::mkdir_p store
    # FileUtils.cp "static#{src}", store

    # %Q({{< image src="/#{path}/#{filename}" title="#{text}" >}})
  end
end

class Paragraph < Content
  def md(path: '')
    result = ''
    @content.children.each do |p|
      elem = p.name
      result << if elem == 'text'
                  p.text
                elsif elem == 'br'
                  "  \n"
                elsif elem == 'a'
                  text = p.children.text
                  value = p.attribute('href').value
                  href = value.match(/.*\/(.+)$/)[1]
                  "[#{text}](#{href})"
                elsif elem == 'u'
                  "<u>**#{p.text}**</u>"
                elsif elem == 'ol'
                  p p
                  brとかaとかの処理が出てくるのでこの辺recursiveに
                  1.
                  1.
                  1.
                  raise
                else
                  raise elem
                end
    end
    result
  end
end

class ImageGallery < Content
end

class Hr < Content
end

class Blockquote < Content
end
