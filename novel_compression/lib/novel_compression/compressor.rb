module NovelCompression
	class Compressor
		def self.compress(input)
			# for each line
			#   tokenize the line
			#   for each token
			#     classify a token into the type
			#     add downcased token to dictionary if not already in it
			#     record the compressed instruction
			# record EOF instruction
		end

		def tokenize(s)
			regex = /\b?(\w+|[-.,?!;:\n])\b?/
			tokens = []
			tokens << s.scan(regex)
			tokens.flatten!
		end
	end
end
