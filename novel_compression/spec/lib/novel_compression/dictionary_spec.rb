require 'spec_helper'
require 'novel_compression/dictionary'

describe NovelCompression::Dictionary do
	describe '#size' do
		it 'is 0 for a new Dictionary' do
			expect(subject.size).to eq(0)
		end
	end

	describe '#<<' do
		it 'increases #size for each added unique word' do
			expect(subject.size).to eq(0)
			subject << 'one'
			expect(subject.size).to eq(1)
			subject << 'two'
			expect(subject.size).to eq(2)
			subject << 'three'
			expect(subject.size).to eq(3)
		end

		it "doesn't increase #size for adding a word already in the dictionary" do
			expect(subject.size).to eq(0)
			subject << 'one'
			expect(subject.size).to eq(1)
			subject << 'one'
			expect(subject.size).to eq(1)
			subject << 'One'
			expect(subject.size).to eq(1)
		end
	end

	describe '#index_for' do
		it 'returns the "index" of a word' do
			d = NovelCompression::Dictionary.new
			d << 'banana'
			d << 'potato'
			d << 'fish'
			d << 'Potato'
			expect(d.index_for 'banana').to eq(1)
			expect(d.index_for 'Banana').to eq(1)
			expect(d.index_for 'potato').to eq(2)
			expect(d.index_for 'fish').to eq(3)
		end
	end

	describe '#word' do
		it 'returns the word for the specified location' do
			d = NovelCompression::Dictionary.new
			d << 'banana'
			d << 'potato'
			d << 'fish'
			d << 'Potato'
			expect(d.word 1).to eq('banana')
			expect(d.word 2).to eq('potato')
			expect(d.word 3).to eq('fish')
		end
	end
end
