module NovelCompression
	class Decompressor
		attr_accessor :dictionary

		def initialize(input)
			@input = input
			@dictionary ||= []
			# First line of input is dictionary size
			word_count = @input.gets.to_i
			# Extract the dictionary from the input
			word_count.times { @dictionary << @input.gets.strip }
			@chunk_regex = /\A(?<number>\d*)(?<operator>[^\d\s]*)\z/
			@output = ""
		end

		def process_instructions(instructions)
			accepted_punctuation =['.', ',', '?', '!', ';', ':']
			@previous_do_not_pad = true
			@do_not_pad = false
			chunks = instructions.split
			chunks.each do |chunk|
				match = @chunk_regex.match chunk
				case match[:operator]
				when 'E' # end of input
					return @output
				when '^' # capitalize the word
					index = Integer(match[:number], 10)
					text = @dictionary[index].capitalize
				when 'R' # new line
					text = '\n'
					@do_not_pad = true
				when '-' # hyphenate previous and next word
					text = '-'
					@do_not_pad = true
				when *accepted_punctuation
					if match[:operator] == '!' and match[:number].length > 0
						# if N! make word full caps
						index = Integer(match[:number], 10)
						text = @dictionary[index].upcase
					else
						# if punctuation by itself
						text = match[:operator]
						text << ' '
						@do_not_pad = true
					end
				when '' # just a word
					index = Integer(match[:number], 10)
					text = @dictionary[index]
				end

				if should_space_be_added
					@output << " "
				end
				@output << text
			end
		end

		def should_space_be_added
			retval = true
			if @previous_do_not_pad
				retval = false
			elsif @do_not_pad
				retval = false
			else
				retval = true
			end

			@previous_do_not_pad = @do_not_pad
			@do_not_pad = false
			return retval
		end
	end
end
