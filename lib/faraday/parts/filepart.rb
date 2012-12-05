# monkey patch from @liluo https://gist.github.com/4176272
class Faraday::Parts::FilePart
  def initialize(boundary, name, io) 
    file_length = io.respond_to?(:length) ?  io.length : File.size(io.local_path)    
    @head = build_head(boundary, name, io.original_filename, io.content_type, file_length,
                       io.respond_to?(:opts) ? io.opts : {}) 
    @length = @head.length + file_length
    @io = CompositeReadIO.new(StringIO.new(@head), io, StringIO.new("\r\n"))
  end 
end