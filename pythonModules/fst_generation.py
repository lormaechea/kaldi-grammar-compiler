#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import os
import copy

def printing(buffeur, etat, etatf):
	if not buffeur.startswith('#'):
		if buffeur != "":		
			print(etat, etatf, buffeur, buffeur, sep='\t')
		else:
			print(etat, etatf, "<eps>", "<eps>", sep='\t')

	if buffeur.startswith('#'):
		print(etat, etatf, buffeur, "<eps>", sep='\t')
		# print(etat, etatf, buffeur, buffeur, sep='\t')


def printingEnd(etatf):
	print(etatf)


iChar = 0
etatCourant = 0

def analyzer(phrase, etatDebut, etatFin):
	# Index initialization:
	global iChar
	global etatCourant

	# Buffer initialization:
	Buff = ""

	Init = etatDebut

	while iChar < len(phrase):

		if phrase[iChar] != "(" and phrase[iChar] != ")" and phrase[iChar] != "|" and phrase[iChar] != " ":
			Buff = Buff + phrase[iChar]
			iChar += 1
			
		else:
			if phrase[iChar] == "(":
				iChar += 1
				etatCourant += 1
				etatDebut = analyzer(phrase, etatDebut, etatCourant)

			elif phrase[iChar] == ")":
				printing(Buff, etatDebut, etatFin)

				iChar += 1
				return etatFin

			elif phrase[iChar] == " " and Buff != "":
				printing(Buff, etatDebut, etatCourant + 1)
				etatCourant += 1
				etatDebut = etatCourant
				Buff = ""
				iChar += 1

			elif phrase[iChar] == "|":
				printing(Buff, etatDebut, etatFin)
				etatDebut = Init
				Buff = ""
				iChar += 1

			else:
				iChar += 1

	printing(Buff, etatDebut, etatCourant + 1)
	printingEnd(etatCourant + 1)



if __name__ == '__main__':
	print("Wouldn't you rather call the main.py?\n")