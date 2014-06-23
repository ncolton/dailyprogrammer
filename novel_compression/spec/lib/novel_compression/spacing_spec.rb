require 'spec_helper'
require 'novel_compression/spacing'

describe Spacing do
	context 'word + word' do
		let(:stack) { [Spacing::WORD, Spacing::WORD] }
		it 'returns true' do
			expect(Spacing.should_space? stack).to be_true
		end
	end
end
