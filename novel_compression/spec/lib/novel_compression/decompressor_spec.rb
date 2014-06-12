require 'rspec'
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
	let(:expected_dictionary) { ['is', 'my', 'hello', 'name', 'stan'] }
	let(:input) { StringIO.new input_string }
	let(:decompressor) { NovelCompression::Decompressor.new input }

	it 'builds a dictionary properly' do
		expect(decompressor.dictionary).to eq(expected_dictionary)
	end

	it 'decompresses' do
		expected_output = "HELLO!\nMy name is Stan."
		expect(decompressor.decompress).to eq(expected_output)
	end
end
