require 'spec_helper'
require 'novel_compression/decompressor'

input_string = <<-EOF
5
is
my
hello
name
stan
2! ! R 1^ 3 0 4^ . E
EOF

describe NovelCompression::Decompressor do
	context 'dictionary parsing' do
		let(:expected_dictionary) { ['is', 'my', 'hello', 'name', 'stan'] }
		let(:input) { StringIO.new input_string }
		let(:decompressor) { NovelCompression::Decompressor.new input }

		it 'builds a dictionary properly' do
			expect(decompressor.dictionary).to eq(expected_dictionary)
		end
	end

	context '#process_instructions' do
		let(:input) { StringIO.new input_string }
		let(:decompressor) { NovelCompression::Decompressor.new input }

		it 'E stops processing the instruction set' do
			res = decompressor.process_instructions 'E'
			expect(res).to eq('')
		end

		it 'N results in word N' do
			res = decompressor.process_instructions '0 2 1 E'
			expect(res).to eq('is hello my')
		end

		it 'N^ results in word N capitalized' do
			res = decompressor.process_instructions '0 2^ 1 E'
			expect(res).to eq('is Hello my')
		end

		it 'N! results in word N upper-cased' do
			res = decompressor.process_instructions '0 2! 1 E'
			expect(res).to eq('is HELLO my')
		end

		it '- hyphen separates the previous and following word' do
			res = decompressor.process_instructions '0 - 0 E'
			expect(res).to eq('is-is')
		end

		it 'R adds a new line' do
			res = decompressor.process_instructions '0 R 2! R 1 E'
			expect(res).to eq('is\nHELLO\nmy')
		end

		it ': appends the symbol to the previous word' do
			res = decompressor.process_instructions '0 : 0 E'
			expect(res).to eq('is: is')
		end

		it '; appends the symbol to the previous word' do
			res = decompressor.process_instructions '0 ; 0 E'
			expect(res).to eq('is; is')
		end

		it '! appends the symbol to the previous word' do
			res = decompressor.process_instructions '0 ! 0 E'
			expect(res).to eq('is! is')
		end

		it '? appends the symbol to the previous word' do
			res = decompressor.process_instructions '0 ? 0 E'
			expect(res).to eq('is? is')
		end

		it ', appends the symbol to the previous word' do
			res = decompressor.process_instructions '0 , 0 E'
			expect(res).to eq('is, is')
		end

		it '. appends the symbol to the previous word' do
			res = decompressor.process_instructions '0 . 0 E'
			expect(res).to eq('is. is')
		end
	end

	context 'operation' do
		let(:input) { StringIO.new input_string }
		let(:decompressor) { NovelCompression::Decompressor.new input }

		# it 'decompresses' do
		# 	expected_output = "HELLO!\nMy name is Stan."
		# 	expect(decompressor.decompress).to eq(expected_output)
		# end
	end
end
