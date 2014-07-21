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

		it "given 'Waffle-maker' should return ['Waffle', '-', 'maker']" do
			expect(subject.tokenize 'Waffle-maker').to eq(['Waffle', '-', 'maker'])
		end
	end

	it '.compress' do
		input = prep_input 'Woof! Woof!'
		output = NovelCompression::Compressor.compress input
		expect(output).to eq('0^ ! 0^ ! E ')
	end

	describe '#classify' do
		it 'handles lower-case words' do
				expect(subject.classify_token 'potato').to be(:word)
		end
		it 'handles capitalised words' do
			expect(subject.classify_token 'Potato').to be(:capitalized_word)
		end
		it 'handles upper-case words' do
			expect(subject.classify_token 'POTATO').to be(:upcased_word)
		end
		it 'handles hyphenation of words' do
			expect(subject.classify_token '-').to be(:hyphen)
		end
		it 'handles punctuation (.,?!;:)' do
			['.', ',', '?', '!', ';', ':'].each do |token|
				expect(subject.classify_token token).to be(:punctuation)
			end
		end
		it 'handles new lines' do
			expect(subject.classify_token "\n").to be(:newline)
		end
	end

	describe '#compress_token' do
		# inject the dict? probably simplest ...
		let(:test_word) { 'supercalifragilistic' }
		it 'handles normal words' do
			index = subject.dictionary << test_word
			expect(subject.compress_token test_word).to eq("#{index} ")
		end
		it 'handles capitalised words' do
			index = subject.dictionary << test_word
			expect(subject.compress_token test_word.capitalize).to eq("#{index}^ ")
		end
		it 'handles upper-cased words' do
			index = subject.dictionary << test_word
			expect(subject.compress_token test_word.upcase).to eq("#{index}! ")
		end
		it 'handles hyphenation of words' do
			expect(subject.compress_token '-').to eq('- ')
		end
		it 'handles punctuation (.,?!;:)' do
			'.,?!;:'.each_char do |character|
				expect(subject.compress_token character).to eq("#{character} ")
			end
		end
		it 'handles new lines' do
			expect(subject.compress_token "\n").to eq("R ")
		end
	end
end
