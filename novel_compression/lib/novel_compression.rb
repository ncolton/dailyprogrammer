require 'novel_compression/version'
require 'novel_compression/decompressor'
require 'novel_compression/spacing'
require 'novel_compression/compressor'

module NovelCompression
  def self.compress(input)
    NovelCompression::Compressor.compress input
  end

  def self.decompress(input)
    decompressor = NovelCompression::Decompressor.new input
    decompressor.text
  end
end
