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
end
