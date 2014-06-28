module NovelCompression
	class Compressor
		def initialize(input)
			@input = input
		end

		def tokenize
			regex = /\b?(\w+|[.,?!;:\n])\b?/
			tokens = []
			@input.readlines.each do |line|
				tokens << line.scan(regex)
			end
			return tokens.flatten
		end
	end
end
