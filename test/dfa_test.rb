# Corey Finley
# 18 November 2013
# dfa_test.rb

require_relative "../lib/dfa.rb"
require "test/unit"

class TestFileReader < Test::Unit::TestCase
	def create_dfa
		return DFA.new("../test-suite/simulator/bigDFA.txt")
	end

	def test_init_file
		dfa = create_dfa
		assert_equal("Number of states: 17", dfa.reader.contents[0])
	end

	def test_state_count
		dfa = create_dfa
		assert_equal(17, dfa.num_states)
	end

	def test_accepting
		dfa = create_dfa
		assert_equal([0, 2, 3, 5, 7, 11, 13], dfa.accepting_states)
	end

	def test_apha
		dfa = create_dfa
		assert_equal(["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"], dfa.alphabet)
	end

	def test_transitions
		dfa = create_dfa
		assert_not_nil(dfa.transitions)
		
		assert_equal(16, dfa.transitions[15][16])
	end

	def test_next_state
		dfa = create_dfa
		assert_equal(16, dfa.next_state("f", 16))
	end

	def test_valid_string
		dfa = create_dfa
		# assert_equal(true, dfa.valid_string?(""))
		puts "accepting = #{dfa.accepting_states.inspect}"
		assert_equal(true, dfa.valid_string?("2d"))
		assert_equal(true, dfa.valid_string?("2d"))
		assert_equal(false, dfa.valid_string?("5f"))
	end

	def test_input_file
		dfa = create_dfa
		dfa.process_inputs("../test-suite/simulator/bigDFA-strings.txt")
	end

	def test_output
		dfa = create_dfa
		dfa.to_file("-TEST")
	end
end