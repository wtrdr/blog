require 'open-uri'

def download(src, dst)
  url = "https://wataridori.weebly.com#{src}"
  open(dst, 'wb') do |output|
    open(url) do |data|
      output.write(data.read)
    end
  end
end

class Content
  def initialize(content)
    @content = content
  end
  def md(path: ''); end
  def head(path: ''); end
end

class Contents < Content
  def md(path: '')
    return '' if @content == []
    @content.map do |c|
      c.md(path: path)
    end.join("\n")
  end
  def head(path: '')
    return nil if @content == []
    @content.map do |c|
      c.head(path: path)
    end.reject{|h| h.nil? || h == ''}.join("\n")
  end
end

class Title < Content
  def md(path: '')
    "## #{@content.text}"
  end
end

class Youtube < Content
  def md(path: '')
    src = @content.css('iframe').attribute('src').value
    id = src.match(/.+\/(.+)\?/)[1]
    "{{< youtube #{id} >}}"
  end
end

class Spacer < Content
  def md(path: '')
    "\n"
  end
end

class Image < Content
  def md(path: '')
    text = @content.text

    src = @content.css('img').attribute('src').value.gsub(/\?.+$/, '')
    name = File.basename(src)

    dir = "static/img/#{path}"
    dst = "#{dir}/#{name}"
    FileUtils::mkdir_p dir

    download(src, dst)
    %Q({{< image classes="fig-100 clear center" thumbnail-width="60%" src="/img/#{path}/#{name}" title="#{text}" >}})
  end
end

class Paragraph < Content
  def md(path: '')
    @content.children.map { |p| parse_p(p) }.join('')
  end

  private

  def parse_p(p)
    elem = p.name
    if elem == 'text'
      return p.text
    elsif elem == 'br'
      return "\n"
    elsif elem == 'a'
      text = p.children.text
      value = p.attribute('href').value
      href = value.start_with?("http") ?
        value :
        value.match(/.*\/(.+)$/)[1]
      return "[#{text}](#{href})"
    elsif elem == 'u'
      return "<u>**#{p.text}**</u>"
    elsif elem == 'ol'
      result = p.css('li').map do |pp|
        res = '1. '
        res << pp.children.map do |ppp|
          result = parse_p(ppp)
          result = "#{result}      " if ppp.name == 'br'
          result
        end.join('')
        res.strip
      end.join("\n")
      return "\n\n#{result}"
    elsif elem == 'ul'
      result = p.css('li').map do |pp|
        res = '- '
        res << pp.children.map do |ppp|
          result = parse_p(ppp)
          result = "#{result}      " if ppp.name == 'br'
          result
        end.join('')
        res.strip
      end.join("\n")
      return "\n\n#{result}"
    elsif elem == 'span'
      p.children.map do |pp|
        parse_p(pp)
      end.join('')
    elsif elem == 'strong'
      res = p.children.map { |pp| parse_p(pp) }.join('')
      return "**#{res}**"
    elsif elem == 'em'
      res = p.children.map { |pp| parse_p(pp) }.join('')
      return "*#{res}*"
    elsif elem == 'font'
      return "### #{p.text}" if p.attribute('size')&.value == '4'
      raise elem
    else
      raise elem
    end
  end
end

class ImageGallery < Content
  def md(path: '')
    srcs = @content.css('a').map do |content|
      src = content.attribute('href').value.gsub(/\?.+$/, '')
      name = File.basename(src)

      dir = "static/img/#{path}"
      dst = "#{dir}/#{name}"
      FileUtils::mkdir_p dir

      download(src, dst)
      "/img/#{path}/#{name}"
    end
    if srcs.size == 1
      %Q({{< image classes="fig-100 clear center" thumbnail-width="60%" src="#{src}" >}})
    elsif srcs.size == 2 || srcs.size == 4
      return srcs.map.with_index do |src, i|
        %Q({{< image classes="fancybox fig-50#{(i % 2 == 1) || (i+1 == srcs.size) ? ' clear' : ''}" src="#{src}" >}})
      end.join("")
    elsif srcs.size == 3
      return srcs.map.with_index do |src, i|
        %Q({{< image classes="fancybox fig-33#{(i % 3 == 2) || (i+1 == srcs.size) ? ' clear' : ''}" src="#{src}" >}})
      end.join("")
    else
      # for head
      # nothing to do
    end
  end

  def head(path: '')
    srcs = @content.css('a').map do |content|
      src = content.attribute('href').value.gsub(/\?.+$/, '')
      name = File.basename(src)
      "/img/#{path}/#{name}"
    end
    return nil unless srcs.size >= 5
    res = "gallery:\n"
    res << srcs.map {|src| "- #{src}" }.join("\n")
    res
  end

end

class Hr < Content
  def md(path: '')
    "--------------------------"
  end
end

class Blockquote < Content
  def md(path: '')
    "> #{@content.text}"
  end
end
