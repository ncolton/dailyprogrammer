require 'spec_helper'
require 'novel_compression/spacing'

describe NovelCompression::Spacing do
	describe '.should_space?' do
		context 'word + word' do
			let(:stack) { [Spacing::WORD, Spacing::WORD] }
			it { expect(subject.should_space? stack).to be_true }
		end
		context 'punctuation + word' do
			let(:stack) { [Spacing::PUNCTUATION, Spacing::WORD] }
			it { expect(subject.should_space? stack).to be_true }
		end

		context 'word + punctuation' do
			let(:stack) { [Spacing::WORD, Spacing::PUNCTUATION] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'word + newline' do
			let(:stack) { [Spacing::WORD, Spacing::NEWLINE] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'word + hyphen' do
			let(:stack) { [Spacing::WORD, Spacing::HYPHEN] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'punctuation + punctuation' do
			let(:stack) { [Spacing::PUNCTUATION, Spacing::PUNCTUATION] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'punctuation + newline' do
			let(:stack) { [Spacing::PUNCTUATION, Spacing::NEWLINE] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'punctuation + hyphen' do
			let(:stack) { [Spacing::PUNCTUATION, Spacing::HYPHEN] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'newline + word' do
			let(:stack) { [Spacing::NEWLINE, Spacing::WORD] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'newline + punctuation' do
			let(:stack) { [Spacing::NEWLINE, Spacing::PUNCTUATION] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'newline + newline' do
			let(:stack) { [Spacing::NEWLINE, Spacing::NEWLINE] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'newline + hyphen' do
			let(:stack) { [Spacing::NEWLINE, Spacing::HYPHEN] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'hyphen + word' do
			let(:stack) { [Spacing::HYPHEN, Spacing::WORD] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'hyphen + punctuation' do
			let(:stack) { [Spacing::HYPHEN, Spacing::PUNCTUATION] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'hyphen + newline' do
			let(:stack) { [Spacing::HYPHEN, Spacing::NEWLINE] }
			it { expect(subject.should_space? stack).to be_false }
		end
		context 'hyphen + hyphen' do
			let(:stack) { [Spacing::HYPHEN, Spacing::HYPHEN] }
			it { expect(subject.should_space? stack).to be_false }
		end
	end
end
