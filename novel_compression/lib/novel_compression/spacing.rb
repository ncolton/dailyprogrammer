module Spacing
	WORD = 'word'
	PUNCTUATION = 'punctuation'
	NEWLINE = 'new line'
	HYPHEN = 'hyphen'

	SHOULD_HAVE_SPACE = [
		[Spacing::WORD, Spacing::WORD],
		[Spacing::PUNCTUATION, Spacing::WORD]
	]

	def self.should_space?(context)
		return true if SHOULD_HAVE_SPACE.include? context
	end
end
