require 'spec_helper'
require 'novel_compression/compressor'

describe NovelCompression::Compressor do
	# /\b?(\w+|[.,?!;:])\b?/
	# /\b?(\w+|\p{Punct})\b?/  -- probably gets punctuation I don’t want
	it '#tokenize' do
		input = StringIO.new "The quick brown fox jumps over the lazy dog.\nOr, did it?"
		compressor = NovelCompression::Compressor.new input
		tokens = compressor.tokenize
		expect(tokens).to be_an(Array)
		expect(tokens).to eq(['The', 'quick', 'brown', 'fox', 'jumps', 'over', 'the', 'lazy', 'dog', '.', "\n", 'Or', ',', 'did', 'it', '?'])
	end
	it '#classify'
	describe '#compress'
end
