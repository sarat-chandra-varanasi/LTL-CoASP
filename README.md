LTL model checker using Coinductive Answer Set Programming

Prerequisites: 
--------------
Install s(CASP) system by following installation steps at: 
https://gitlab.software.imdea.org/ciao-lang/sCASP

Usage:
-----

Launch the ltl.lp file using s(CASP) in CoASP Mode [--co] flag as follows:

scasp -i --no_nmr --co ltl.lp 

This will launch s(CASP) in interactive and CoASP mode. 

At the prompt issue verify queries over a state and LTL formulas

For example:

?- verify(s1, f(g(p)))    %% To check if F G p holds in state s1

Note: All the state transitions and the atomic propositions that hold in a state should be specified as trans/2 and holds/2 facts
See the example within the ltl.lp file (at the end) 


