module NovelCompression
	class Decompressor
		attr_accessor :dictionary

		def initialize(input)
			@input = input
			@dictionary ||= []
			word_count = @input.gets.to_i
			word_count.times { @dictionary << @input.gets.strip }
			@chunk_regex = /\A(?<number>\d*)(?<operator>[^\d\s]*)\z/
		end

		def process_instructions(instructions)
			chunks = instructions.split
			output = ""
			chunks.each do |chunk|
				match = @chunk_regex.match chunk
				case match[:operator]
				when 'E'
					return output
				when '^'
					index = Integer(match[:number], 10)
					text = @dictionary[index].capitalize
				when '!'
					index = Integer(match[:number], 10)
					text = @dictionary[index].upcase
				when 'R'
					text = '\n'
					@previous_word_is_newline = true
				else
					index = Integer(match[:number], 10)
					text = @dictionary[index]
				end

				output << " " if output.length > 0 and should_space_be_added
				output << text
			end
		end

		def should_space_be_added
			@previous_word_is_newline ||= false
			@hyphenate_previous_word ||= false

			if @previous_word_is_newline
				@previous_word_is_newline = false
				return false
			end

			if @hyphenate_previous_word
				@hyphenate_previous_word = false
				return false
			end

			return true
		end

		def parse_base_10_int(s)
			begin
				val = Integer(match[:number], 10)
			rescue ArgumentError
				val = nil
			end
			return val
		end
	end
end
