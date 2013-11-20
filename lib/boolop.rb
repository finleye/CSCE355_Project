# Corey Finley
# 18 November 2013
# dfs_sim.rb

# require_relative "./dfa.rb"
require "#{File.dirname(__FILE__)}/dfa.rb"

class BoolOpArgumentError < ArgumentError; end

class BoolOp
	attr_accessor :dfa, :dfa2

	# create the boolop object for processing. It consists of one or two DFA's
	def initialize(files)
		@dfa = DFA.new(files[0])
		@dfa2 = DFA.new(files[1]) if files[1] && files[1].class == String
	end

	# generate the DFA by buildling an Array of states, and skipping those that are currently accepting.
	def gen_compliment
		new_states = Array.new
		for i in 0..self.dfa.num_states-1
			new_states << i unless self.dfa.accepting_states.include?(i)
		end
		self.dfa.accepting_states = new_states
	end

	# build the intersection of the two DFAs
	def intersection
		# break if there aren't two DFA's
		return nil unless self.dfa && self.dfa2

		# build the new states by cartesian product
		# resulting states will be of the format  x|y
		new_states = Array.new
		self.dfa.states.each do |x|
			self.dfa2.states.each do |y|
				new_states << "#{x}|#{y}"
			end
		end

		# find what the new accepting states by processing the 
		# cartisian product of the previous accepting states
		new_accepting = Array.new
		self.dfa.accepting_states.each do |x|
			self.dfa2.accepting_states.each do |y|
				accepting = "#{x}|#{y}"
				new_accepting << new_states.index(accepting)
			end
		end

		# recreate the dfa
		intersection_dfa = self.dfa
		intersection_dfa.accepting_states = new_accepting
		intersection_dfa.num_states = new_states.count
		intersection_dfa.states = intersection_dfa.get_states
		hash_table = Hash.new

		# loop over the alphabet 
		intersection_dfa.alphabet.each do |a|
			# loop over states and find the resulting states
			for i in 0..intersection_dfa.num_states-1
				state = new_states[i].split('|')
				output_state = "#{self.dfa.next_state(a, state[0].to_i)}|#{self.dfa2.next_state(a, state[1].to_i)}"
				key = new_states.index(output_state)

				# process each new state and convert it to a state based on the new_states collection
				hash_table[intersection_dfa.alphabet.index(a)] = hash_table[intersection_dfa.alphabet.index(a)] << key unless hash_table[intersection_dfa.alphabet.index(a)].nil?
				hash_table[intersection_dfa.alphabet.index(a)] ||= Array.new << key
			end
		end

		# reset the transistion states
		intersection_dfa.transitions = hash_table
		return intersection_dfa
	end
end