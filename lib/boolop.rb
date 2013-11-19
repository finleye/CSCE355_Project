# Corey Finley
# 18 November 2013
# dfs_sim.rb

require_relative "./dfa.rb"

class BoolOpArgumentError < ArgumentError; end

class BoolOp
	attr_accessor :dfa, :dfa2

	def initialize(files)
		@dfa = DFA.new(files[0])
		@dfa2 = DFA.new(files[1]) if files[1] && files[1].class == String
	end

	def gen_compliment
		compliment_states = self.get_compliment_states

		compliment = self.dfa
		compliment.accepting_states = compliment_states
		compliment.transitions = self.dfa.transitions

		return compliment
	end

	def get_compliment_states
		new_states = Array.new

		for i in 0..self.dfa.num_states-1
			new_states << i unless self.dfa.accepting_states.include?(i)
		end

		return new_states
	end

	def intersection
		return nil unless self.dfa && self.dfa2

		new_states = Array.new
		self.dfa.states.each do |x|
			self.dfa2.states.each do |y|
				new_states << "#{x}|#{y}"
			end
		end

		new_accepting = Array.new
		self.dfa.accepting_states.each do |x|
			self.dfa2.accepting_states.each do |y|
				accepting = "#{x}|#{y}"
				new_accepting << new_states.index(accepting)
			end
		end

		intersection_dfa = self.dfa
		intersection_dfa.accepting_states = new_accepting
		intersection_dfa.num_states = new_states.count
		intersection_dfa.states = intersection_dfa.get_states
		hash_table = Hash.new

		for i in 0..intersection_dfa.num_states-1
			intersection_dfa.alphabet.each do |a|
				state = new_states[i].split('|')
				output_state = "#{self.dfa.next_state(a, state[0].to_i)}|#{self.dfa2.next_state(a, state[1].to_i)}"
				key = new_states.index(output_state)

				hash_table[i] = hash_table[i] << key unless hash_table[i].nil?
				hash_table[i] ||= Array.new << key
			end
		end

		intersection_dfa.transitions = hash_table
		return intersection_dfa
	end
end