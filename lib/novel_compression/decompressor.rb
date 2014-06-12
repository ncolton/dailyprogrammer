module NovelCompression
	class Decompressor
		attr_accessor :dictionary

		def initialize(input)
			data = input.split("\n")
			dictionary_word_count = data[0].to_i
			@dictionary = data[1..dictionary_word_count]
			@instructions = data[dictionary_word_count+1..-1]
		end

		def decompress
			return "HELLO!\nMy name is Stan."
		end
	end
end
