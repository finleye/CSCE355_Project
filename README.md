CSCE 355 Programming Assignment
===============================
19 November 2013

This project meets the requirements for the following two options;
* Simulator - Read in a DFA file and process a file of inputs for testing
	Using the DFA class defined in `dfa.rb`. The script defined in `my_dfa_simulator.rb` handles
	capturing command line arguments to build a DFA object and process the inputs file.
* Compliment/Intersection - Read one DFA from command line and return compliment, or read two 
	DFA's and return their intersection. The `boolop.rb` defines a class to hold one or two DFA's
	as well as the functions that manipulate the two DFA's. `my_boolop.rb` is a script that handles
	capturing one or two input file paths and returns either the compliment of a single DFA 
	or the intersection of two DFA's.

Note
****
Both classes take advantage of the `file_reader.rb` which simply reads a file and returns 
a collection `contents` which is just an Array of lines of type String

Development Enviroment
**********************
`ruby 2.0.0p195 (2013-05-14 revision 40734) [x86_64-darwin12.4.0]` on OS X 10.9
Update 20 November 2013
`ruby 1.8.7 (2011-06-30 patchlevel 352) [i686-linux]` on Ubuntu 12.04
