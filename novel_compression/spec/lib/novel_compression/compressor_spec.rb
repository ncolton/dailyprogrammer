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
		expect(output).to eq("1\nwoof\n0^ ! 0^ ! E ")
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
		it 'considers single letter words capitalised instead of upper-cased' do
			expect(subject.classify_token 'I').to be(:capitalized_word)
			expect(subject.classify_token 'A').to be(:capitalized_word)
		end
	end

	describe '#compress_token' do
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

	context 'Challenge example Input' do
		'./spec/test_data/compressor/'
		let(:input) { open './spec/test_data/compressor/example_data_input.txt' }
		let(:expected_output) do
			fd = open './spec/test_data/compressor/example_data_output.txt'
			fd.read.chomp
		end
		skip 'results in Challenge example Output' do
			expect(NovelCompression::Compressor.compress input).to eq(expected_output)
		end

		it 'results in Challenge example Output (like the example)' do
			input = prep_input "The quick brown fox jumps over the lazy dog.\nOr, did it?"
			expected_output = "11\nthe\nquick\nbrown\nfox\njumps\nover\nlazy\ndog\nor\ndid\nit\n0^ 1 2 3 4 5 0 6 7 . R 8^ , 9 10 ? E "
			expect(NovelCompression::Compressor.compress input).to eq(expected_output)
		end
	end

	context 'Challenge Input' do
		let(:input) { open './spec/test_data/compressor/challenge_input.txt' }
		let(:expected_output) do
			fd = open './spec/test_data/compressor/challenge_output.txt'
			fd.read.chomp
		end
		it 'results in Challenge Output' do
			expect(NovelCompression::Compressor.compress input).to eq(expected_output)
		end
	end
end
