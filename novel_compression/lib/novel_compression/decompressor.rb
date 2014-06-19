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
			accepted_punctuation =['.', ',', '?', '!', ';', ':']
			@previous_word_is_newline = true
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
					@do_not_pad = true
				when '-'
					text = '-'
					@do_not_pad = true
				when *accepted_punctuation
					text = match[:operator]
					text << ' '
					@do_not_pad = true
				when ''
					index = Integer(match[:number], 10)
					text = @dictionary[index]
				else
					text = ''
					@do_not_pad = true
				end

				if should_space_be_added
					output << " "
				end
				output << text
			end
		end

		def should_space_be_added
			retval = true
			if @previous_word_is_newline
				retval = false
			elsif @do_not_pad
				retval = false
			else
				retval = true
			end

			@previous_word_is_newline = @do_not_pad
			@do_not_pad = false
			return retval
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
