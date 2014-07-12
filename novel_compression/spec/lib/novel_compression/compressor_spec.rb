require 'spec_helper'
require 'novel_compression/compressor'

def prep_input(s)
	return StringIO.new s
end

describe NovelCompression::Compressor do
	# /\b?(\w+|[.,?!;:])\b?/
	# /\b?(\w+|\p{Punct})\b?/  -- probably gets punctuation I don’t want
	it '#tokenize' do
		input = "The quick brown fox jumps over the lazy dog.\nOr, did it?\n"
		tokens = subject.tokenize input
		expect(tokens).to be_an(Array)
		expect(tokens).to eq(['The', 'quick', 'brown', 'fox', 'jumps', 'over', 'the', 'lazy', 'dog', '.', "\n", 'Or', ',', 'did', 'it', '?', "\n"])
	end

	describe '#classify' do
		it 'handles normal words'
		it 'handles capitalised words'
		it 'handles upper-cased words'
		it 'handles hyphenation of words'
		it 'handles punctuation (.,?!;:)'
		it 'handles new lines'
	end

	describe '#compress_token' do
		it 'handles normal words'
		it 'handles capitalised words'
		it 'handles upper-cased words'
		it 'handles hyphenation of words'
		it 'handles punctuation (.,?!;:)'
		it 'handles new lines'
	end
end
