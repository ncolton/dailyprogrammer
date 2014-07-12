require 'spec_helper'
require 'novel_compression/compressor'

def prep_input(s)
	return StringIO.new s
end

describe NovelCompression::Compressor do
	# /\b?(\w+|[.,?!;:])\b?/
	# /\b?(\w+|\p{Punct})\b?/  -- probably gets punctuation I don’t want
	describe '#tokenize' do
		it 'returns an array' do
			expect(subject.tokenize '').to be_an(Array)
		end

		context 'when given a simple sentence' do
			let(:input) { "The quick brown fox jumps over the lazy dog.\nOr, did it?\n" }
			let(:result) { subject.tokenize input }

			it 'returns the proper tokens' do
				expect(result).to eq(['The', 'quick', 'brown', 'fox', 'jumps', 'over', 'the', 'lazy', 'dog', '.', "\n", 'Or', ',', 'did', 'it', '?', "\n"])
			end
		end

		context '"Waffle-maker"' do
			let(:input) { "Waffle-maker" }
			let(:result) { subject.tokenize input }
			it { expect(result).to eq(['Waffle', '-', 'maker']) }
		end
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
