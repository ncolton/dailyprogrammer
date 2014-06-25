require 'novel_compression/spacing'

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
			@decoded_text = nil
		end

		def text
			return @decoded_text unless @decoded_text.nil?
			lines = @input.readlines.collect { |line| line.strip }
			@decoded_text = process_instructions(lines.join(" "))
		end

		def process_instructions(instructions)
			accepted_punctuation =['.', ',', '?', '!', ';', ':']
			decoded_chunks = []
			decoded_chunks_types = []
			chunks = instructions.split
			chunks.each do |chunk|
				match = @chunk_regex.match chunk
				case match[:operator]
				when 'E' # end of input
					return build_output decoded_chunks, decoded_chunks_types
				when '^' # capitalize the word
					decoded_chunks << @dictionary[decode_index match[:number]].capitalize
					decoded_chunks_types << Spacing::WORD
				when 'R' # new line
					decoded_chunks << "\n"
					decoded_chunks_types << Spacing::NEWLINE
				when '-' # hyphenate previous and next word
					decoded_chunks << '-'
					decoded_chunks_types << Spacing::HYPHEN
				when *accepted_punctuation
					if match[:operator] == '!' and match[:number].length > 0
						# if N! make word full caps
						decoded_chunks << @dictionary[decode_index match[:number]].upcase
						decoded_chunks_types << Spacing::WORD
					else
						# if punctuation by itself
						decoded_chunks << match[:operator]
						decoded_chunks_types << Spacing::PUNCTUATION
					end
				when '' # just a word
					decoded_chunks << @dictionary[decode_index match[:number]]
					decoded_chunks_types << Spacing::WORD
				end
			end
		end

		def decode_index(s)
			index = Integer(s, 10)
		end

		def build_output(chunks, chunks_types)
			output_string = "#{chunks[0]}"
			index = 1
			while index + 1 <= chunks_types.length
				if Spacing::should_space? chunks_types[(index - 1)..index]
					output_string << " "
				end
				output_string << chunks[index]
				index = index + 1
			end

			return output_string
		end
	end
end
