require 'novel_compression/dictionary'

module NovelCompression
	class Compressor
		attr_reader :instructions
		attr_accessor :dictionary
		ACCEPTED_PUNCTUATION = ['.', ',', '?', '!', ';', ':']

		def self.compress(input)
			compressor = self.new
			input.each do |line|
				tokens = compressor.tokenize line
				tokens.each do |token|
					# classify a token into the type
					# if word, add token to dictionary if not already in it
					# record the compressed instruction
				end
				# record EOF instruction (END_INPUT)
			end
		end

		def initialize
			@instructions = []
			@dictionary = Dictionary.new
		end

		def tokenize(s)
			regex = /\b?(\w+|[-.,?!;:\n])\b?/
			tokens = []
			tokens << s.scan(regex)
			tokens.flatten!
		end

		def classify_token(token)
			case token
			when "\n"
				return :newline
			when '-'
				return :hyphen
			when *ACCEPTED_PUNCTUATION
				return :punctuation
			when /[[:alpha:]]/
				if token == token.upcase
					return :upcased_word
				elsif token == token.capitalize
					return :capitalized_word
				else
					return :word
				end
			end
		end

		def compress_token(token)
			token_classification = classify_token token
			case token_classification
			when :newline
				"R "
			when :hyphen
				"- "
			when :punctuation
				"#{token} "
			when :word, :capitalized_word, :upcased_word
				token_index = dictionary.index_for token
				case token_classification
				when :word
					handling_instruction = ''
				when :capitalized_word
					handling_instruction = '^'
				when :upcased_word
					handling_instruction = '!'
				end
				"#{token_index}#{handling_instruction} "
			end
		end
	end
end
