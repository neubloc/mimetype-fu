# Author:: Grzegorz Derebecki (mailto:gderebecki@neublock.com)
# modified version of plugin http://github.com/jdhollis/mimetype-fu.git
# in some system file works not the same way (in some we have --mime-types)
# in another we have only --mime. Becous of this we use only --mime (with exists everywere except windows)
# and strip optionaly outputed charset
require 'tempfile'
require File.dirname(__FILE__) + '/extensions_const'

class File
  def self.mime_type(file)
    case file
    when File, Tempfile
      mime = parse(`file --mime -br "#{file.path}"`.strip) unless RUBY_PLATFORM.include? 'mswin32'
      mime = EXTENSIONS[File.extname(file.path).gsub('.','').downcase.to_s] if mime == 'application/octet-stream' || mime.nil?
    when String
      mime = EXTENSIONS[(file[file.rindex('.')+1, file.size]).downcase.to_s] unless file.rindex('.').nil?
    when StringIO
      temp = File.open(Dir.tmpdir + '/upload_file.' + Process.pid.to_s, 'wb')
      temp << file.string
      temp.close
      mime = parse(`file --mime -br "#{temp.path}"`.strip)
      File.delete(temp.path)
    end
    
    return mime || 'unknown/unknown'
  end

  def self.parse(mime)
    mime.gsub(/^.*: */,"").gsub(/;.*$/,"").gsub(/,.*$/,"").gsub(/;? charset=.*/, "")
  end
  
  def self.extensions
    EXTENSIONS
  end
end
