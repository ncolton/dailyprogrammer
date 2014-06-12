require 'rspec'
require 'spec_helper'
require 'novel_compression/decompressor'

input = <<-EOF
5
is
my
hello
name
stan
2! ! R 1^ 3 0 4^ . E
EOF

expected_dictionary = ['is', 'my', 'hello', 'name', 'stan']

describe 'decompressor' do
	it 'builds a dictionary from provided text' do
		decomp = NovelCompression::Decompressor.new input
		expect(decomp.dictionary).to eq(expected_dictionary)
	end

	it 'decompresses' do
		expected_output = "HELLO!\nMy name is Stan."

		decomp = NovelCompression::Decompressor.new input
		expect(decomp.decompress).to eq(expected_output)
	end

	context '#process_chunk' do
		it 'returns the appropriate word' do
		end
	end
end
