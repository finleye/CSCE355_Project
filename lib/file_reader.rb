# Corey Finley
# 18 November 2013
# file_reader.rb

class FileReaderAgumentError < ArgumentError; end

class FileReader
	attr_accessor :file_name, :contents

	def initialize(file)
		@file_name = file
		@contents = self.read_contents
	end

	# open the file, split its contents at line breaks and return the collection of lines
	def read_contents
		return File.open(self.file_name).read.split(/\n/) if self.file_name
	end
end