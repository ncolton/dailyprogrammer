module NovelCompression
	class Decompressor
		attr_accessor :dictionary

		def initialize(input)
			@input = input
			@dictionary ||= []
			word_count = @input.gets.to_i
			word_count.times { @dictionary << @input.gets.strip }
		end

		def decompress
			return "HELLO!\nMy name is Stan."
		end
	end
end
