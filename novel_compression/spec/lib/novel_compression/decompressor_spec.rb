require 'spec_helper'
require 'novel_compression/decompressor'

challenge_example_input_string = <<-EOF
5
is
my
hello
name
stan
2! ! R 1^ 3 0 4^ . E
EOF

# Note that this needs it's last new line stripped
challenge_example_expected_output = <<-EOF
HELLO!
My name is Stan.
EOF

challenge_input_string = <<-EOF
20
i
do
house
with
mouse
in
not
like
them
ham
a
anywhere
green
eggs
and
here
or
there
sam
am
0^ 1 6 7 8 5 10 2 . R
0^ 1 6 7 8 3 10 4 . R
0^ 1 6 7 8 15 16 17 . R
0^ 1 6 7 8 11 . R
0^ 1 6 7 12 13 14 9 . R
0^ 1 6 7 8 , 18^ - 0^ - 19 . R E
EOF

challenge_expected_output = <<-EOF
I do not like them in a house.
I do not like them with a mouse.
I do not like them here or there.
I do not like them anywhere.
I do not like green eggs and ham.
I do not like them, Sam-I-am.
EOF

describe NovelCompression::Decompressor do
	context 'dictionary parsing' do
		let(:expected_dictionary) { ['is', 'my', 'hello', 'name', 'stan'] }
		let(:input) { StringIO.new challenge_example_input_string }
		let(:decompressor) { NovelCompression::Decompressor.new input }

		it 'builds a dictionary properly' do
			expect(decompressor.dictionary).to eq(expected_dictionary)
		end
	end

	context '#process_instructions' do
		let(:input) { StringIO.new challenge_example_input_string }
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
			expect(res).to eq("is\nHELLO\nmy")
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
		let(:input) { StringIO.new challenge_example_input_string }
		let(:decompressor) { NovelCompression::Decompressor.new input }

		# it 'decompresses' do
		# 	expected_output = "HELLO!\nMy name is Stan."
		# 	expect(decompressor.decompress).to eq(expected_output)
		# end
	end

	context 'Challenge Input and Output' do
		context 'Example' do
			let(:input) { StringIO.new challenge_example_input_string }
			let(:decompressor) { NovelCompression::Decompressor.new input }
			it 'correctly decompresses the example input' do
				expect(decompressor.text + "\n").to eq(challenge_example_expected_output)
			end
		end

		context 'Challenge' do
			let(:input) { StringIO.new challenge_input_string }
			let(:decompressor) { NovelCompression::Decompressor.new input }
			it 'correctly decompresses the challenge input' do
				expect(decompressor.text).to eq(challenge_expected_output)
			end
		end
	end
end
