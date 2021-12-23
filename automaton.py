#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#####################################################################
# DESCRIPTION	:	A Python script that creates the FST for every 
#					normalized phrase.
# EXECUTION 	:	(inside genGrammar.sh)
#####################################################################

import sys

import pythonModules.fst_generation as fstgen


def main():
	# FST initialization:
	state = 0

	# We call the analyzing fonction:
	fstgen.analyzer(' '.join(sys.argv[1:]), state, state + 1)



if __name__ == '__main__':
	main()