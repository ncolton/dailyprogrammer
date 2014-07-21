module NovelCompression
	# Used for storing words used by the compressor and decompressor.
	# All words are stored in lower case, with a single entry for any
	# given word, and the order of the words is static.
	#
	# No facility for removal of words is given, as removal of words
	# is not something that makes sense for the needs it fills in
	# NovelCompression.
	class Dictionary
		def initialize
			@words = {}
			@word_index = []
		end

		# @method size
		#
		# Returns the number of entries in the dictionary.
		#
		# @return [Fixnum]
		def size
			return @words.size
		end

		# @method <<
		#
		# If not already present, adds a word to the dictionary.
		#
		# @param s [String]
		def <<(s)
			word = s.downcase
			return index_for word if @words.has_key? word
			# I'm being creative here to make look up and storage easy and
			# 'ordered': The downcased word is the key, and the 'index' is
			# the value in the hash. This will keep look up speeds by word,
			# and storage speeds quite good, while maintaining a constant
			# index for the word.
			@words[word] = @words.size
			@word_index[@words[word]] = word
			return index_for word
		end

		# @method index_for
		#
		# Look up the index for a word
		#
		# @param word [String]
		def index_for(word)
			return @words[word.downcase]
		end

		# @method word
		#
		# Look up a word by it's index
		#
		# @param index [Fixnum]
		def word(index)
			@word_index[index]
		end
	end
end
