require 'spec_helper'
require 'novel_compression/compressor'

describe NovelCompression::Compressor do
	# \b?(\w+|[.,?!;:])\b?
	# \b?(\w+|\p{Punct})\b?  -- probably gets punctuation I don’t want
	it '#tokenize'
	it '#classify'
end
