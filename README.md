CSCE 355 Programming Assignment
*******************************
19 November 2013

This project meets the requirements for the following two options;
* Simulator - Read in a DFA file and process a file of inputs for testing
	Using the DFA class defined in `dfa.rb`. The script defined in `my_dfa_simulator.rb` handles
	capturing command line arguments to build a DFA object and process the inputs file.
* Compliment/Intersection - Read one DFA from command line and return compliment, or read two 
	DFA's and return their intersection. The `boolop.rb` defines a class to hold one or two DFA's
	as well as the functions that manipulate the two DFA's.

Note: Both classes take advantage of the `file_reader.rb` which simply reads a file and returns 
a collection `contents` which is just an Array of lines of type String
