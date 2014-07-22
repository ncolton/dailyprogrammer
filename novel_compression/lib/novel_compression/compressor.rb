require 'novel_compression/dictionary'

module NovelCompression
	class Compressor
		attr_reader :instructions
		attr_accessor :dictionary
		ACCEPTED_PUNCTUATION = ['.', ',', '?', '!', ';', ':']

		def self.compress(input)
			compressor = self.new
			output = []
			input.each do |line|
				tokens = compressor.tokenize line
				tokens.each do |token|
					token_type = compressor.classify_token token
					if token_type == :word || token_type == :capitalized_word || token_type == :upcased_word
						compressor.dictionary << token
					end
					output << compressor.compress_token(token)
				end
			end
			output << 'E '
			"#{compressor.dictionary}\n" + output.join
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
