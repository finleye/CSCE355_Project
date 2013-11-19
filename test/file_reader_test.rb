# Corey Finley
# 18 November 2013
# file_reader_test.rb

require_relative "../lib/file_reader.rb"
require "test/unit"

class TestDFAReader < Test::Unit::TestCase
	def test_init_file
		reader = FileReader.new("../test-suite/simulator/bigDFA.txt")
		assert_equal("../test-suite/simulator/bigDFA.txt", reader.file_name)
	end

	def test_contents
		reader = FileReader.new("../test-suite/simulator/bigDFA.txt")
		assert_not_nil(reader.contents)
		assert_equal("Number of states: 17", reader.contents[0])
	end
end

