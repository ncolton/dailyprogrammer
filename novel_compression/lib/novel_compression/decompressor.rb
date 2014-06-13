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
				return output if 'E'.eql? match[:operator]

				output << " " if output.length > 0

				index = Integer(match[:number], 10)

				case match[:operator]
				when '^'
					text = @dictionary[index].capitalize
				when '!'
					text = @dictionary[index].upcase
				else
					text = @dictionary[index]
				end

				output << text
			end
		end
	end
end
