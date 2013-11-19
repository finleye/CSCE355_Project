# Corey Finley
# 18 November 2013
# file_reader_test.rb

require_relative "../lib/boolop.rb"
require "test/unit"

class TestBoolOp < Test::Unit::TestCase
	def init_bool_op
		file_name = "../test-suite/boolop/smallDFA.txt"
		file_name2 = "../test-suite/boolop/smallDFA2.txt"
		bool = BoolOp.new([file_name, file_name2])
	end

	def test_init_file
		bool = init_bool_op
		assert_equal([2], bool.dfa.accepting_states)
	end

	def test_compliments
		bool = init_bool_op
		assert_equal([0, 1, 3, 4], bool.get_compliment_states)
	end

	def test_comp_gen
		bool = init_bool_op
		assert_equal([0, 1, 3, 4], bool.gen_compliment.accepting_states)
	end

	def test_ouput
		file_name = "../test-suite/boolop/bigDFA.txt"
		bool = BoolOp.new([file_name])
		compliment = bool.gen_compliment
		compliment.to_file("-comp-TEST")

		expected_out = File.open("#{bool.dfa.reader.file_name.split('.txt')[0]}-comp.txt").read.split(/\n/)
		actual_out = File.open("#{bool.dfa.reader.file_name.split('.txt')[0]}-comp-TEST.txt").read.split(/\n/)

		assert_equal(expected_out[2], actual_out[2])
	end

	def test_intersection
		bool = init_bool_op
		compliment = bool.intersection

		compliment.to_file("-TEST")
	end
end